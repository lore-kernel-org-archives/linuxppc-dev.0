Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7A07B7B7A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 22:06:33 +1100 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate6.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n9FB650X695582
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 11:06:10 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n9FB5mN42465960
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 12:05:54 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n9FB5ljT028376
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 12:05:48 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
Date: Thu, 15 Oct 2009 13:05:47 +0200
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
In-Reply-To: <1255557226-4403-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200910151305.47100.borntraeger@de.ibm.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	brueckner@linux.vnet.ibm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch 14 Oktober 2009 23:53:46 schrieben Sie:
> hvc_console_print() calls the HVC client driver's put_chars() callback
> to write some characters to the console.  If the callback returns 0, that
> indicates that no characters were written (perhaps the output buffer is
> full), but hvc_console_print() treats that as an error and discards the
> rest of the buffer.
> 
> So change hvc_console_print() to just loop and call put_chars() again if it
> returns a 0 return code.
> 
> This change makes hvc_console_print() behave more like hvc_push(), which
>  does check for a 0 return code and re-schedules itself.

There is a difference between console and tty, if the console call does not 
return, it might bring the full system to a stop. (if its the preferred console, 
init will stop)

> This patch might fix drivers that return 0 to indicate that they're busy, such 
> as arch/powerpc/platforms/pseries/hvconsole.c. It will break drivers that
> return 0 if their output buffer is full, but where those buffers cannot be
> emptied while the kernel is in a loop.

Yep. I think it really depends on the backend if looping will result in any 
progress or not. My experience wth hvc_console is, that its quite hard to get 
changes tested on all backends. (e.g. XEN, pseries, iseries, virtio_console, 
s390_iucv...), so even if this change turns out to be correct, it should 
probably sit in linux-next for a while. In additon I really dont oversee, what 
backends wil break due to this patch.

The fact that struct console->write returns void indicates that the console 
layer is not interested in errors. We have two policies we can implement:

1. drop console messages if case of congestion but keep the system going
2. dont drop messages and wait, even if the system might come to a complete stop 

Looking at drivers/char/vt.c 
        /* console busy or not yet initialized */
        if (!printable)
                return;
        if (!spin_trylock(&printing_lock))
                return;
could mean that  Linux consoles should not block.

Maybe its time to ask some of the elder magicians (CCing Alan Cox and linux-
kernel) about blocking and error handling in console code.


> --- a/drivers/char/hvc_console.c
> +++ b/drivers/char/hvc_console.c
> @@ -161,7 +161,7 @@ static void hvc_console_print(struct console *co, const
>  char *b, }
>  		} else {
>  			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
> -			if (r <= 0) {
> +			if (r < 0) {
>  				/* throw away chars on error */
>  				i = 0;
>  			} else if (r > 0) {
> 
