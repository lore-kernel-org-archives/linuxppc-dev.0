Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3758F1A0020
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 13:21:07 +1000 (EST)
Message-ID: <540E7211.9020909@zytor.com>
Date: Mon, 08 Sep 2014 20:20:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
References: <21512.10628.412205.873477@gargle.gargle.HOWL>			
 <20140904090952.GW17454@tucnak.redhat.com>			
 <540859EC.5000407@hurleysoftware.com>			
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>			
 <5408C0AB.6050801@hurleysoftware.com>			
 <20140905001751.GL5001@linux.vnet.ibm.com>			
 <1409883098.5078.14.camel@jarvis.lan>		
 <5409243C.4080704@hurleysoftware.com>			
 <20140905040645.GO5001@linux.vnet.ibm.com>			
 <1410066442.12512.13.camel@jarvis.lan>			
 <20140907162146.GK5001@linux.vnet.ibm.com>		
 <1410116687.2027.19.camel@jarvis.lan>	 <540CC305.8010407@hurleysoftware.com>
 <1410155407.2027.29.camel@jarvis.lan>	 <540E3BFF.7080307@hurleysoftware.com>
 <1410231392.2028.15.camel@jarvis.lan>
In-Reply-To: <1410231392.2028.15.camel@jarvis.lan>
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Miroslav Franc <mfranc@redhat.com>,
 Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/08/2014 07:56 PM, James Bottomley wrote:
>>
>> Yeah, the extra requirement I added is basically nonsense, since the
>> only issue is what instructions the compiler is emitting. So if compiler
>> thinks the alignment is natural and combines the writes -- ok. If the
>> compiler thinks the alignment is off and doesn't combine the writes --
>> also ok.
> 
> Yes, I think I can agree that the only real problem is gcc thinking the
> store or load needs splitting.
> 

That seems much saner, and yes, that applies to any architecture which
needs unaligned references.  Now, if the references are *actually*
unaligned they can end up being split even on x86, especially if they
cross cache line boundaries.

	-hpa
