Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.cn.alcatel-lucent.com
	(cnmailgate04.alcatel-sbell.com.cn [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id 6892DB6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Dec 2009 02:10:42 +1100 (EST)
Message-ID: <4B3AD271.1050105@alcatel-lucent.com>
Date: Tue, 29 Dec 2009 23:09:21 -0500
From: gshan <gshan@alcatel-lucent.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: xmon & SCSI ATA devices
References: <4B33197D.9000506@alcatel-lucent.com>
	<1262079428.2173.218.camel@pasglop>
In-Reply-To: <1262079428.2173.218.camel@pasglop>
Content-Type: text/html; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Benjamin Herrenschmidt wrote:
<blockquote cite="mid1262079428.2173.218.camel@pasglop" type="cite">
  <pre wrap="">On Thu, 2009-12-24 at 02:34 -0500, gshan wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello,

xmon and SCSI SATA device driver were installed on my system. When I invoked
xmon explicitly for kernel debugging, there're probably pending SCSI 
requests issued.
So those SCSI requests complained timeout when I quited from xmon. I want to
find a way to suspend SCSI device before invoking xmon and resume that 
before
quiting from xmon. Anybody knew there is a way to do this?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, it's non trivial. xmon is very low level and doesn't muck around
with drivers etc...
  </pre>
</blockquote>
Yes. I agree.<br>
<blockquote cite="mid1262079428.2173.218.camel@pasglop" type="cite">
  <pre wrap="">
We could add hacks to avoid those timeouts or even do what you suggest
with suspending devices, but that would make entering xmon a -lot- more
fragile. The idea is that xmon relies on very little kernel services and
can be entered even when things are utterly wrong.
  </pre>
</blockquote>
Actually, the situation I described above has caused lots of disk issue.<br>
The DPT (disk partition table) might be lost because of this. I think
it's<br>
broken the rule: xmon is assisting to resolve kernel issue, not cause<br>
more.<br>
<blockquote cite="mid1262079428.2173.218.camel@pasglop" type="cite">
  <pre wrap="">
To be honest, I'm tempted to leave that as it is. Most of the time,
getting into xmon is a one way trip.... 
  </pre>
</blockquote>
<blockquote cite="mid1262079428.2173.218.camel@pasglop" type="cite">
  <pre wrap="">
Cheers,
Ben.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Thanks,
Gavin
_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
<br>
</body>
</html>
