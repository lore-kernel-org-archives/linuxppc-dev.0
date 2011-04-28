Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2E2EB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 01:25:50 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C32983EE0B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 00:25:45 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9E5D945DD74
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 00:25:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F7A645DE55
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 00:25:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6E90DE08003
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 00:25:45 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2FD3E1DB803A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 00:25:45 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] powerpc: convert old cpumask API into new one
In-Reply-To: <BANLkTi=EvC6E_p+XSpzZUvhu0Q_gStROcQ@mail.gmail.com>
References: <20110429000901.3D66.A69D9226@jp.fujitsu.com>
	<BANLkTi=EvC6E_p+XSpzZUvhu0Q_gStROcQ@mail.gmail.com>
Message-Id: <20110429002723.3D74.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Apr 2011 00:25:44 +0900 (JST)
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>, kosaki.motohiro@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > @@ -268,9 +269,9 @@ void __init cbe_regs_init(void)
> >                                thread->regs = map;
> >                                thread->cbe_id = cbe_id;
> >                                map->be_node = thread->be_node;
> > -                               cpu_set(i, cbe_local_mask[cbe_id]);
> > +                               cpumask_set_cpu(i, &cbe_local_mask[cbe_id]);
> >                                if(thread->thread_id == 0)
> while you are here, could you add a space between if and ( ?


Oh, this is NOT a part of my change. I don't want to insert unrelated
cleanup.
