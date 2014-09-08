Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [12.216.194.151])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05B331A0121
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 06:51:33 +1000 (EST)
Message-ID: <540E1587.3060108@tilera.com>
Date: Mon, 8 Sep 2014 16:45:59 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Peter Hurley
 <peter@hurleysoftware.com>
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
 <1410116687.2027.19.camel@jarvis.lan> <540CC305.8010407@hurleysoftware.com>
 <1410155407.2027.29.camel@jarvis.lan>
In-Reply-To: <1410155407.2027.29.camel@jarvis.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Jakub Jelinek <jakub@redhat.com>, One
 Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-arch@vger.kernel.org,
 linux-ia64@vger.kernel.org, Mikael Pettersson <mikpelinux@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, paulmck@linux.vnet.ibm.com,
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

On 9/8/2014 1:50 AM, James Bottomley wrote:
> Actual alignment is pretty irrelevant.  That's why all architectures
> which require alignment also have to implement misaligned traps ... this
> is a fundamental requirement of the networking code, for instance.

Can you clarify what you think the requirement is?  The tile architecture
doesn't support misaligned load/store in general, but we do support it for
userspace (using a nifty JIT approach with a direct-map hash table kept
in userspace), and also for get_user/put_user.  But that's it, and,
the networking subsystem works fine for us.

Occasionally we report bugs for driver code that doesn't use the
get_unaligned_xxx() macros and friends, and our fixes are generally taken
upstream.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
