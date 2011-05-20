Return-Path: <ericvh@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B82CB71B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 10:47:59 +1000 (EST)
Received: by fxm5 with SMTP id 5so2694250fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 17:47:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305851769.7481.90.camel@pasglop>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-5-git-send-email-ericvh@gmail.com>
	<1305851769.7481.90.camel@pasglop>
Date: Thu, 19 May 2011 19:47:55 -0500
Message-ID: <BANLkTimc3jQTOJdqAiqbPxGQNVWe39VqfQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] [RFC] force 32-byte aligned kmallocs
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 7:36 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2011-05-18 at 16:24 -0500, Eric Van Hensbergen wrote:
>>
>> -#ifdef CONFIG_NOT_COHERENT_CACHE
>> +#if defined(CONFIG_NOT_COHERENT_CACHE) || defined(CONFIG_BGP)
>> =A0#define ARCH_DMA_MINALIGN =A0 =A0L1_CACHE_BYTES
>> =A0#endif
>
> Is DMA cache coherent on BG/P ? That's odd for a 4xx base :-)
>

My understanding of things (which could be totally wrong) is that the
DMA we care about on BG/P (namely the Torus and Collective networks)
is coherent at the L2.  Of course the change in question is talking
about L1_CACHE_BYTES, so my reading of this is that its a sleazy way
of getting aligned mallocs that make interactions with the tightly
coupled networks easier/more-efficient.  I'm open to alternative
suggestions.

      -eric
