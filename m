Message-ID: <3879F9E6.EF018D4E@mvista.com>
Date: Mon, 10 Jan 2000 09:25:26 -0600
From: Jim Lewis <jlewis@mvista.com>
MIME-Version: 1.0
To: LiuTao <tliu@ict.ac.cn>
CC: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem with gunzip()
References: <38799BA3.269E8869@ict.ac.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have had a problem such as yours that was caused by corruption in the
compressed s-record image once it was on the target. I had thought that
Gunzip would catch this, but it did not. How is your image being
transmitted to the target? Is it over a serial link? In my case, the
S-record loader was not checking checksums and occasionally, a serial
transmission error went undetected. Gunzip did not complain, but the
uncompressed image would end up being skewed by a few bytes.
Hope this helps.


LiuTao wrote:

> Hi
>
> When I ported linux to a board with MPC860, 16M RAM and 2M Flash,
> I met a problem.
> After the program gunzip()(misc.c) the vmlinux image to address 0x0,
> the contents from 0x0 to IMAGE_SIZE should be as same as that in
> linux/vmlinux, right? I found that they are not same. Only from 0x0
> to about 0xb500, they are same.
> I don't think gunzip() has any problem.
> Do you have any suggestions?
> Thanks!
>
> LiuTao

--
Jim Lewis
Sr. Field Applications Engineer
MontaVista Software, Inc.
(817)261-9088 http://www.mvista.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
