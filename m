Return-Path: <SRS0+273ff7d6ec6624edc474+755+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA3F0682DD
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Sep 2005 04:13:05 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17196.5625.322927.221055@cargo.ozlabs.ibm.com>
References: <1126956437.4171.20.camel@baythorne.infradead.org>
	<17196.5625.322927.221055@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 17 Sep 2005 19:12:58 +0100
Message-Id: <1126980778.4171.25.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	Davide Libenzi <davidel@xmailserver.org>, viro@ftp.linux.org.uk
Subject: Re: Repeated corruption of file->f_ep_lock
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-09-17 at 23:11 +1000, Paul Mackerras wrote:
> They look like part of an exception stack frame. 

Aha, thanks. Now... any ideas about how they're getting into struct
file? It's always at the same offset in the struct, and it's not at the
same offset in the page each time -- this is happening all over the
place.

e.g....

Sep 17 11:09:34 peach kernel: File cb789760 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 11:09:34 peach kernel: lock 24042084, owner_pc 0, owner_cpu 901
--
Sep 17 11:11:07 peach kernel: File c70038c0 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 11:11:07 peach kernel: lock 24042484, owner_pc 0, owner_cpu 901
--
Sep 17 11:12:22 peach kernel: File c89c0320 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 11:12:22 peach kernel: lock 24042484, owner_pc 0, owner_cpu 901
--
Sep 17 12:02:02 peach kernel: File c90378a0 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:02:02 peach kernel: lock 24022484, owner_pc 0, owner_cpu 901
--
Sep 17 12:04:57 peach kernel: File c962b3e0 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:04:57 peach kernel: lock 28000484, owner_pc 0, owner_cpu 901
--
Sep 17 12:08:01 peach kernel: File cb245700 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:08:01 peach kernel: lock 24042884, owner_pc 0, owner_cpu 901
--
Sep 17 12:11:00 peach kernel: File c64e5aa0 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:11:00 peach kernel: lock 28000484, owner_pc 0, owner_cpu 901
--
Sep 17 12:13:15 peach kernel: File c0a1eac0 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:13:15 peach kernel: lock 28000484, owner_pc 0, owner_cpu 901
--
Sep 17 12:21:44 peach kernel: File caeb3360 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:21:44 peach kernel: lock 24042084, owner_pc 0, owner_cpu 901
--
Sep 17 12:24:25 peach kernel: File caeb3d60 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:24:25 peach kernel: lock 28000484, owner_pc 0, owner_cpu 901
--
Sep 17 12:25:08 peach kernel: File c6b24300 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:25:08 peach kernel: lock 28000484, owner_pc 0, owner_cpu 901
--
Sep 17 12:25:09 peach kernel: File ca6465c0 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:25:09 peach kernel: lock 24022484, owner_pc 0, owner_cpu 901
--
Sep 17 12:26:59 peach kernel: File c9037c60 (fops d107c980) has corrupted f_epoll_lock!
Sep 17 12:26:59 peach kernel: lock 28000484, owner_pc 0, owner_cpu 901
--
Sep 17 12:29:55 peach kernel: File ca64b120 (fops c031f44c) has corrupted f_epoll_lock!
Sep 17 12:29:55 peach kernel: lock 20000484, owner_pc 0, owner_cpu 901



-- 
dwmw2
