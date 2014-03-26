Return-Path: <amodra@gmail.com>
Received: from mail-pb0-x233.google.com (mail-pb0-x233.google.com
 [IPv6:2607:f8b0:400e:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB793140090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 21:06:46 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id uo5so1712741pbc.24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 03:06:43 -0700 (PDT)
Date: Wed, 26 Mar 2014 20:36:36 +1030
From: Alan Modra <amodra@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 15/33] powerpc: Fix ABIv2 issues with stack offsets in
 assembly code
Message-ID: <20140326100636.GO18201@bubble.grove.modra.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
 <1395747879-5948-16-git-send-email-anton@samba.org>
 <20140326100449.GN18201@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140326100449.GN18201@bubble.grove.modra.org>
Cc: mikey@neuling.org, rusty@rustcorp.com.au, ulrich.weigand@de.ibm.com,
 mjw@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2014 at 08:34:49PM +1030, Alan Modra wrote:
> On Tue, Mar 25, 2014 at 10:44:21PM +1100, Anton Blanchard wrote:
> > Fix STK_PARAM and use it instead of hardcoding ABIv1 offsets.
> 
> >  _GLOBAL(memcpy)
> >  BEGIN_FTR_SECTION
> > -	std	r3,48(r1)	/* save destination pointer for return value */
> > +	std	r3,STK_PARAM(R3)(r1)	/* save destination pointer for return value */
> 
> Here and elsewhere you're assuming you have a parameter save area.
> That won't be true with ELFv2 for calls to functions like memcpy.

Nevermind, I see you fixed that with the next patch..

-- 
Alan Modra
Australia Development Lab, IBM
