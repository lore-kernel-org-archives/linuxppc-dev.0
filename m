Return-Path: <bergner@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC287DDE2F
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 12:47:01 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBK1kwhO015236
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 20:46:58 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBK1kw0Q438404
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 18:46:58 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBK1kvrZ014988
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 18:46:57 -0700
Subject: Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
From: Peter Bergner <bergner@vnet.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061220004653.GL5506@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 19:46:50 -0600
Message-Id: <1166579210.4963.15.camel@otta>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-19 at 18:46 -0600, Linas Vepstas wrote:
> Per xchat, here's the update. I'm guessing I'm using a broken
> compiler, as per chain of evidence below ...
[snip]
> However, I also note that the following scrolled by:
> init/main.c:81:2: warning: #warning gcc-4.1.0 is known to miscompile the
> kernel. A different compiler version is recommended.

It may be due to this GCC bug which Olaf ran into a while back:

  http://gcc.gnu.org/bugzilla/show_bug.cgi?id=24644

You can verify whether you have a broken compiler by compiling
the minimal test case I posted in comment #15.  If you see r13
being copied into another register and then used, then you have
a broken compiler.

Peter
