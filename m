Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (unknown [76.245.85.235])
	by ozlabs.org (Postfix) with ESMTP id 33961B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 14:41:51 +1000 (EST)
Date: Mon, 21 Sep 2009 21:10:17 -0700
From: Brad Boyer <flar@allandria.com>
To: "dibacco@libero.it" <dibacco@libero.it>
Subject: Re: High load average  but low cpu (xenomai can be the explanation?)
Message-ID: <20090922041017.GA30525@cynthia.pants.nu>
References: <17851044.2911671253545985517.JavaMail.root@wmail27>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17851044.2911671253545985517.JavaMail.root@wmail27>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2009 at 05:13:05PM +0200, dibacco@libero.it wrote:
> I have an MPC880 @133MHz. If I look into the load (with uptime) I get 
> values around 3.0 but my CPU is always under 5 percent (top). How could I 
> explain this? I'm using linux 2.6.19 with xenomai but no xenomai application is 
> running at all. I have a cramfs on a nor flash. What could be the problem? If I 
> kill the process I developed the average load goes down.

Does your system have any kernel modules that are used as part of the
application you are creating? I've seen this happen with custom written
kernel modules that sleep in an uninterruptible wait during a call
from a program or inside a kernel thread. This shows up as 'D' state
in your ps output. Any thread in state 'D' counts against the load
average but doesn't show in CPU usage if it is actually sleeping.

I don't think this is the most likely explanation since you said you
can kill your process, but I thought I should mention it.

	Brad Boyer
	flar@allandria.com
