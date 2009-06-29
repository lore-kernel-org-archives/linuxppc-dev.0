Return-Path: <iant@google.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D2052B7094
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 07:40:12 +1000 (EST)
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D070DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 07:40:12 +1000 (EST)
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id n5TLTglR000710
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 14:29:42 -0700
Received: from pxi7 (pxi7.prod.google.com [10.243.27.7])
	by zps38.corp.google.com with ESMTP id n5TLTe3r020660
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 14:29:40 -0700
Received: by pxi7 with SMTP id 7so841486pxi.12
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 14:29:40 -0700 (PDT)
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: Inline Assembly queries
References: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
	<abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
From: Ian Lance Taylor <iant@google.com>
Date: Mon, 29 Jun 2009 14:29:38 -0700
In-Reply-To: <abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
	(kernel mailz's message of "Mon\, 29 Jun 2009 21\:19\:57 +0530")
Message-ID: <m3ljna20fx.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel mailz <kernelmailz@googlemail.com> writes:

> I tried a small example
>
> int *p = 0x1000;
> int a = *p;
> asm("sync":::"memory");
> a = *p;
>
> and
>
> volatile int *p = 0x1000;
> int a = *p;
> asm("sync");
> a = *p
>
> Got the same assembly.
> Which is right.
>
> So does it mean, if proper use of volatile is done, there is no need
> of "memory" ?

You have to consider the effects of inlining, which may bring in other
memory loads and stores through non-volatile pointers.

Ian
