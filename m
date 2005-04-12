Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E690767B14
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 02:12:34 +1000 (EST)
Date: Tue, 12 Apr 2005 09:12:31 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Daniel Ann <ktdann@gmail.com>
Message-ID: <20050412161230.GA18567@gate.ebshome.net>
References: <9b7ca6570504120138738b554f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b7ca6570504120138738b554f@mail.gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Trying to understand alloc_skb()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 12, 2005 at 05:38:01PM +0900, Daniel Ann wrote:
> My problem is that, kernel dies with "alloc_skb called nonatomically
> from interrupt c00ba718" message. After browsing mailing list, I think
> its to do with not providing it with enough locks prior.
> 
> Question is, what kind of lock should I be providing ?

You don't need any locks, just pass correct gfp_mask parameter to 
alloc_skb when it's called from IRQ context, e.g. GFP_ATOMIC.

--
Eugene
