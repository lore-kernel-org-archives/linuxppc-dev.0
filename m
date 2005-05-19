Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1288867A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 12:09:55 +1000 (EST)
Date: Wed, 18 May 2005 19:09:53 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050519020953.GB11587@gate.ebshome.net>
References: <c3d0340b050518175411c484e3@mail.gmail.com>
	<20050519012404.GA11587@gate.ebshome.net>
	<c3d0340b05051818524c647e61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05051818524c647e61@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: DMA consistent allocation is limited to 2MB on 2.6.11 for
	ppc440?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, May 18, 2005 at 06:52:52PM -0700, Shawn Jin wrote:
> Then what's your recommendation to allocate a big chunk of memory for
> pci device? 

My recommendation - don't do this. Why do you need to allocate this 
big chunk of consistent memory in the first place? You can do DMA 
_without_ allocating "consistent" memory. In fact, this is how 
virtually all devices work in Linux. For more info about DMA API - 
look at Documentation/DMA-API.txt.

Technically, you can make consistent pool bigger, if you really insist 
on using this approach.

-- 
Eugene
