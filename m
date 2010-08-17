Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id 4201BB6EDF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 17:08:40 +1000 (EST)
Message-ID: <4C6A3573.3070403@neli.hopto.org>
Date: Tue, 17 Aug 2010 09:08:35 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: [PATCH 4/9] RapidIO: Add relation links between RIO device
	structures
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-5-git-send-email-alexandre.bounine@idt.com>
	<4C692C9D.6040100@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F1F@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F1F@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bounine, Alexandre wrote:
>> As RapidIO is a switched network, the concept of 'previous' and 'next'
>> devices is invalid. Perhaps it's just the way they were
>> discovered/enumerated, but that does not matter any more at runtime.
>> Or at least, should not matter.
>>
> 
> Yes, the "previous" and "next" have to be considered in context of
> enumeration/discovery.
> At runtime, it does not matter for data traffic, but is valuable
> information for error recovery

I agree it's desirable to have this information. Notes:
1) is rio_dev->prev used anywhere? (maybe I missed it)
2) is the nextdev[port] list complete? I mean are all connected switches 
in the list? My guess is that multiply connected switches are enumerated 
only once therefore only appear in the nextdev if only one switch, 
instead of all
3) it would be nice to have all switch connections information.

In case ever the network is rerouted, this information will become 
useful; instead of having a tree representation of the network only.

Micha
