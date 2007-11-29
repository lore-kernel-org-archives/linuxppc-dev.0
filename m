Return-Path: <cn.vijaibaskar@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id A4129DDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 18:24:41 +1100 (EST)
Received: from [172.29.36.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id D73378780C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 23:24:29 -0800 (PST)
Received: from mail.gdatech.co.in (unknown [172.29.36.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 8B2138780AF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 23:24:29 -0800 (PST)
Message-ID: <474E6A58.2070200@gdatech.co.in>
Date: Thu, 29 Nov 2007 12:59:28 +0530
From: vijay baskar <cn.vijaibaskar@gdatech.co.in>
MIME-Version: 1.0
To: =?UTF-8?B?6YOt5Yqy?= <guojin02@tsinghua.org.cn>
Subject: Re: The question about the high memory support on MPC8360?
References: <396305910.05464@tsinghua.org.cn>
In-Reply-To: <396305910.05464@tsinghua.org.cn>
Content-Type: text/html; charset=UTF-8
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"=
>
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
=E9=83=AD=E5=8A=B2 wrote:
<blockquote cite=3D"mid396305910.05464@tsinghua.org.cn" type=3D"cite">
  <pre wrap=3D"">Hi,friends,

   I plug in 2GB DDR-1 in my MPC8360 board,there are two DIMM-184 slots,e=
ach
DIMM-184 slot hold 1GB.Could you tell me how to let the linux know about =
those
2GB?
   In uboot, I set up each DDR CS to visit 512MB, total 4 CS signal. DDR =
window
range is 2GB. I think the uboot has passed those DDR parameter to linux.
   I once did a test that config the bootargs with mem=3D512M, then the l=
inux just
only find 512MB, but if I config the mem=3D2048M, the linux still find ab=
out 750MB.
   How to make the linux find the total 2GB memory?

  </pre>
</blockquote>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hi Friend,<br>
<br>
I hope u had tracked the conversion that has been going on. The max mem
that the kernel can show is only 768 MB because only that of memory is
directly mapped with your ram.. No matter how much ram &gt; 768 MB (in
powerpc.. it varies in other architectures) u have, the kernel will
show only 768 MB.. This is called low mem.. <br>
<br>
How t o use high mem??<br>
<br>
scott can probably guide us on this.. I also have lot of confusions
about high mem.. Also i would suggest you a bit of reading on virtual
memory management on linux to get a grasp about how things are done<br>
Rest for scott<br>
<br>
regards,<br>
vijai<br>
<br>
<blockquote cite=3D"mid396305910.05464@tsinghua.org.cn" type=3D"cite">
  <pre wrap=3D"">


  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">From: Scott Wood <a class=3D"moz-txt-link-rfc2396E" hr=
ef=3D"mailto:scottwood@freescale.com">&lt;scottwood@freescale.com&gt;</a>
Reply-To:=20
To: vijay baskar <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:cn.vij=
aibaskar@gdatech.co.in">&lt;cn.vijaibaskar@gdatech.co.in&gt;</a>
Subject: Re: The question about the high memory support on MPC8360?
Date:Wed, 28 Nov 2007 10:57:38 -0600

vijay baskar wrote:
    </pre>
    <blockquote type=3D"cite">
      <pre wrap=3D"">Hi, "The kernel also allows hardcoded mapping of IO =
regions into its=20
virtual address space through the io_block_mapping interface."

Can u tell me how this is in current arch/powerpc.
      </pre>
    </blockquote>
    <pre wrap=3D"">Everything is explicitly ioremapped.

    </pre>
    <blockquote type=3D"cite">
      <pre wrap=3D"">Also does it mean that whatever be the size of the r=
am &gt; 768 MB there
 is not going to be much improvement in performance in kernel space=20
irrespective of invoking CONFIG_HIGHMEM or not?
      </pre>
    </blockquote>
    <pre wrap=3D"">Well, the kernel can use highmem for cache...  I'm not=
 sure what you
mean by "in kernel space".

    </pre>
    <blockquote type=3D"cite">
      <pre wrap=3D"">Also do you think this low mem be enough if i have l=
ots of kernel=20
space processes each invoking lots of kmallocs.
      </pre>
    </blockquote>
    <pre wrap=3D"">That depends on what you mean by "lots". :-)

You'll have 768MB of lowmem, and kmallocs can only use lowmem.

    </pre>
    <blockquote type=3D"cite">
      <pre wrap=3D"">Will there be bottle necks?? Also what alternative d=
o we have if  low
mem of 768 MB is not enough??
      </pre>
    </blockquote>
    <pre wrap=3D"">You'll need to change the user/kernel split, and deal =
with anything that=20
breaks in the process.

Or get a 64-bit chip. :-)

-Scott

    </pre>
  </blockquote>
  <pre wrap=3D""><!---->


  </pre>
</blockquote>
<br>
</body>
</html>
