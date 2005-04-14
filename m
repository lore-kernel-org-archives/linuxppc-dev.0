Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 1E27F67B67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 22:36:36 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 70so773670wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 05:36:24 -0700 (PDT)
Message-ID: <9b7ca657050414053650cc817@mail.gmail.com>
Date: Thu, 14 Apr 2005 21:36:24 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Daniel Ann <ktdann@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <9b7ca65705041305327bd600f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570504120138738b554f@mail.gmail.com>
	<20050412161230.GA18567@gate.ebshome.net>
	<9b7ca657050412215025872ce3@mail.gmail.com>
	<20050413051326.GA12632@gate.ebshome.net>
	<9b7ca65705041305327bd600f6@mail.gmail.com>
Subject: Re: Trying to understand alloc_skb()
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/13/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> Then do it. It should be trivial to unwind the stack and much simpler
> than moving this code to process context.

You know what ?? You were right about it being trivial. Didnt take me
to too long to find the line and saw what was going on.
Initially I started reading on how to put the line in process context,
but soon I realised its not something you want to spend your afternoon
on :P (Currently I dont have too many afternoons for this)

Anyway, thanks for the pointer.

Actual problem came from rtnetlink.c file where it called
rtmsg_ifinfo(). This in turn, called alloc_skb with GFP_KERNEL, rather
an GFP_ATOMIC. I guess GFP_KERNEL is right, but what's the difference
?

--=20
Daniel
