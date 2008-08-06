Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 0C03ADE7B3
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 09:11:27 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so28532anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 16:11:27 -0700 (PDT)
Message-ID: <fa686aa40808061611m2cf02242n72941ade6341b9f5@mail.gmail.com>
Date: Wed, 6 Aug 2008 17:11:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
In-Reply-To: <1218061709.24157.249.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
	<1218061709.24157.249.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 4:28 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>> there is a bunch of error checking and difference in semantics that
>> you need to fix.  I think introduce a new API for this is silly,
>> especially since we expect there to only be one actual invocation of
>> the API for serial console access.
>
> Not necessarily....
>
> There's another aspect to BAT mappings here. First, they should be
> permanent (ie, not unmappable). That way, we have ioremap just use
> an existing BAT mapping when asked for a device that is covered
> by a BAT. This allows to have platform code do something like setup
> a BAT over a bunch of SOC registers or over a device, to automagically
> get drivers doing ioremap to that area benefit from it.

Actually, that is exactly what I am in the process of doing right now
for all the 5200 platforms.  It is a performance win with no apparent
downside.

Next I want to investigate if it makes sense to do it for PCI IO regions.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
