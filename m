Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 7BB3C67B72
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Aug 2006 14:17:44 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1658383ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 01 Aug 2006 21:17:42 -0700 (PDT)
Message-ID: <528646bc0608012117i6a5afb37l7e9ee327309aca9b@mail.gmail.com>
Date: Tue, 1 Aug 2006 22:17:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Clint Thomas" <cthomas@soneticom.com>
Subject: Re: Booting Linux Kernel without bootloader
In-Reply-To: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/25/06, Clint Thomas <cthomas@soneticom.com> wrote:
>
>
> Hey guys,
>
> I have gone through the Linuxppc embedded and dev lists for information
> related to what I am trying to do, but was unable to find exactly what i'm
> looking for.
>
> Basically, the system I want linux running on does not require the
> initialization of hardware that U-boot provides, or at least it does not
> need it to boot the linux kernel. I want to load an uncompressed linux
> kernel into memory and start the execution of the kernel, without using any
> kind of bootloader. Is this possible? Or does linux need some kind of
> firmware or other software to tell it to start executing? Thanks for any
> info you might have.

Loading a kernel into memory and starting execution *is* a boot loader.  :)

You could use the bootwrapper that is in the kernel source tree
(zImage).  If a zImage's entry point is at the execution entry point,
then it will start the Linux kernel correctly.  However, it is still a
compressed image.

If you *really* need an uncompressed image, I would start with the
bootwrapper and hack it to work with an non-gzipped kernel image.
However, why do you want to do it this way?  You probably won't gain
much in boot time and it will be more difficult to maintain.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
