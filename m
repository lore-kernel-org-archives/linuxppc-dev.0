Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D872067A05
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 23:52:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] fix spu_callbacks BUILD_BUG_ON
Date: Fri, 21 Apr 2006 15:52:38 +0200
References: <20060421080239.GC4717@suse.de> <200604211245.27744.arnd@arndb.de>
	<Pine.LNX.4.61.0604211512370.23180@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604211512370.23180@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604211552.38923.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, Paul Mackerras <paulus@samba.org>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 April 2006 15:14, Jan Engelhardt wrote:
> +      [__NR_syscalls] = NULL,
> 
> > };
> > 

> >-      if (s->nr_ret >= __NR_syscalls) {
> >+      if (s->nr_ret >= ARRAY_SIZE(spu_syscall_table)) {
> 
> +       if(syscall == NULL) {
> 
> 
> 
> That way, syscalls could be added in the master table while spu does not 
> break. Comments?

Hmm, my idea was not having to check for NULL pointers when we know
that they are valid function calls. But you are right that your approach
is more robust. It also means that we might just leave out all
the assignments to sys_ni_syscall in order to make the source a little
shorter.

	Arnd <><
