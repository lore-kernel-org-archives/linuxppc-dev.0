To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Feb 2002 14:29:39 PST."
             <200202252229.g1PMTdQ02395@xdr.com>
Date: Mon, 25 Feb 2002 23:41:24 +0100
Message-Id: <20020225224129.40BF9109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200202252229.g1PMTdQ02395@xdr.com> you wrote:
>
> There is an issue here where I'm trying to give you or whoever is interested
> in this thread a test program to run that will demonstrate the problem.
> I don't actually bang the SMC or CPM or whatever, I am trying to do
> perfectly valid stuff with a user level program accessing io space of
> pci devices. There is no kernel level code accessing the device I'm trying
> to work with. It makes absolutely no difference where the mmap goes to, as
> long as it is not normal system ram.

Did you ever check the address returned from the mmap() call?  Is  it
always the same, or in the same range, or does it actually look as if
you were leaking mmap()ed memory even though you unmapped it?

Which errno is returned when mmap() fails?



Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How many seconds are there in a year? If I tell you there are 3.155 x
10^7, you won't even try to remember it. On the other hand, who could
forget that, to within half a percent, pi seconds is  a  nanocentury.
                                               -- Tom Duff, Bell Labs

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
