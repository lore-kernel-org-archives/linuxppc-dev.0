Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 91260DDECA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 02:54:42 +1000 (EST)
Message-ID: <46C9C70D.9080903@ovro.caltech.edu>
Date: Mon, 20 Aug 2007 09:53:33 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: signals handling in the kernel
References: <12032525.post@talk.nabble.com>
	<46B8A3C9.7060806@ovro.caltech.edu>	<46B8BA93.8020909@ovro.caltech.edu>
	<12234438.post@talk.nabble.com>
In-Reply-To: <12234438.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Mirek,

> In my case I found somehow more convenient to deal with
> signals.

Ok.

> The server program which I use was originally written
> for VxWorks. In VxWorks there was no separation betwenn
> the user and kernel space. When the interrupt occured
> in VxWorks the interrupt service routine was called.
> The interrupt service routine was implemented in the server. 
> 
> I found it somehow easier to use signals to trigger signal handler
> (previously in VxWorks interrupt service routine) than changing the
> structure of the server to deal with select().

I guess it depends on what you consider 'easier'.
Signals have potential race conditions, and so using
select() is safer. I find it 'easier' to have less
problems, so would spend the time to make the server
use select().

But, you are free to ignore this advice. :)

> I hope however that there is no fundamental problem with
> sending signals from kernel (interrupt service routine)
> to the user space.

There are potential race conditions. I'm not sure if this
problem was 2.4 kernel specific, or 2.6 kernel specific,
or signals specific. I think its signals specific.

A web search should yield more info on this. Try googling
'signals race condition', and it looks like its a problem
still.

So it depends on whether your server is running in
a critical, and secure system, as to whether you want
to stick with signals.

> I do not know why the function kill_proc_info does not 
> export its symbol within the kernel 2.6.21 .
> With previous version of the kernel 2.4 and early 2.6.*
> the kill_proc_info symbol was exported.

If SIGIO is sufficient for you, then just use the driver
fasync() call-back mechanism. The example code I referred
to has an example. If its not clear to you, I can
explain it.

If you're having to modify some corner of the kernel not
used by many, then I'm sure your solution is not the
correct one, and you won't get anyone helping you
when things go wrong.

So, take the experience of others; re-write the server
to use signals. If the server was well written to start
with you should be able to call the 'signal handler'
function after returning from your select() call with
the handle ready. It shouldn't be that hard.

Come on, you've just returned from holiday, it should
be no sweat to code up a new server :)

Regards,
Dave
