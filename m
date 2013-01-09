Return-Path: <bergner@vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C72692C01E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 10:06:40 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bergner@vnet.ibm.com>;
 Wed, 9 Jan 2013 16:06:38 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D3ADD3E40040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2013 16:06:29 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r09N6LgC049478
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2013 16:06:23 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r09N8NmO028367
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2013 16:08:24 -0700
Subject: Re: [PATCH] powerpc: POWER7 optimised memcpy using VMX and
 enhanced prefetch
From: Peter Bergner <bergner@vnet.ibm.com>
To: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <9A768D6E-D4DC-4F8B-ADAC-A1E953B38462@pobox.com>
References: <20120531162209.04bd9bdc@kryten>
 <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
 <20121217223333.6cb00476@kryten> <1355790373.5180.26.camel@otta>
 <16080DCD-0E42-43E9-93E3-D3076637DCB1@pobox.com>
 <1355848269.5180.41.camel@otta>
 <9A768D6E-D4DC-4F8B-ADAC-A1E953B38462@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Jan 2013 17:06:10 -0600
Message-ID: <1357772770.29491.1848.camel@otta>
Mime-Version: 1.0
Cc: "paulus@samba.org Mackerras" <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Kumar Gala <kumar.gala@gmail.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-01-09 at 16:19 -0600, Jimi Xenidis wrote:
> I agree, but that means it is impossible for the same .S file can be compiled
> but -mcpu=e500mc and -mcpu=powerpc?  So either these files have to be Book3S
> versus Book3E --or-- we use a CPP macro to get them right.
> FWIW, I prefer the latter which allows more code reuse.

I agree using a CPP macro - like we do for "new" instructions for which some
older assemblers might not support yet - is probably the best solution.

Peter
