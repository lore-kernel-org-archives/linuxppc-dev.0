Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BED5B2C0125
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 11:22:16 +1000 (EST)
Message-ID: <1343006528.29855.25.camel@pasglop>
Subject: Re: [PATCH -V3 05/11] arch/powerpc: remove masking top 16 bit of va
 in tlb invalidate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 23 Jul 2012 11:22:08 +1000
In-Reply-To: <20120722235610.GE17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120722235610.GE17790@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 09:56 +1000, Paul Mackerras wrote:
> > That indicate we should not mask the top 16 bits. So remove the
> same.
> 
> Older versions of the architecture (2.02 and earler) require the
> masking, so we can't just unconditionally remove it, since that would
> potentially break POWER5 and PPC970.  People are definitely still
> running Linux bare-metal on PPC970s (though arguably not on POWER5). 

Are you sure ? I couldn't convince myself ... the old architectures say
that it only uses some of the bits but it doesn't mark the other ones as
"reserved" (as in must be 0).

(At least 1.x, I haven't looked at 2.x with x < 03)

Cheers,
Ben.
