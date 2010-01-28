Return-Path: <lonsn2005@gmail.com>
Received: from mail-pz0-f188.google.com (mail-pz0-f188.google.com
	[209.85.222.188]) by ozlabs.org (Postfix) with ESMTP id DCE0DB7CE7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 01:47:32 +1100 (EST)
Received: by pzk26 with SMTP id 26so620428pzk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jan 2010 06:47:31 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 28 Jan 2010 22:47:31 +0800
Message-ID: <6caf4b5a1001280647p49984279g7cd034d824182c80@mail.gmail.com>
Subject: mmap performance of reserved top sdram in powerpc platform
From: Lonsn <lonsn2005@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: lonsn@163.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all:
I have reserved top 128MBytes sdram for PCI DMA usage.  External PCI
master sends data to top sdram and then wake up user space app.
User space use /dev/mem and mmap to access this region and then send
them to network using socket.
I found send speed of memory data in /dev/mem to network is very slow.
(300Mbits/s)
If I malloc memory data in user space and then send to network, the
speed is much higher. (750Mbits/s).
I know the reason is the sdram in /dev/mem marked as un-cached.
How can I set the top sdram as cached to impove performance and be
sure that the data is coherent.
My kernel version is DENX-v2.6.32.

Thanks.
