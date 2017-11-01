Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRlg74sR7zDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 22:02:43 +1100 (AEDT)
Date: Wed, 1 Nov 2017 22:02:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
Message-ID: <20171101110241.GA17203@fergus.ozlabs.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171027043430.GA27483@fergus.ozlabs.ibm.com>
 <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
 <20171028223532.GA5587@ram.oc3035372033.ibm.com>
 <20171029220417.GA3317@fergus.ozlabs.ibm.com>
 <20171030005106.GD5587@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171030005106.GD5587@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 29, 2017 at 05:51:06PM -0700, Ram Pai wrote:
> On Mon, Oct 30, 2017 at 09:04:17AM +1100, Paul Mackerras wrote:
> > On Sat, Oct 28, 2017 at 03:35:32PM -0700, Ram Pai wrote:
> > > 
> > > I like the idea of not tracking the slots at all. It is something the
> > > guest should not be knowing or tracking.
> > 
> > Why do you say that?
> 
> 'slot' is a internal mechanism used by the hash table to accelerate
> mapping an address to a hash-page.  If the hash-table implementation
> choose to use a different mechanism to accelerate the mapping, it can't
> because that mechanism is baked into the logic of all the consumers.

Not all operating systems use the HPT as a cache of translations that
are also stored somewhere, as Linux does.  Those OSes are perfectly
entitled to control the slot allocation for their own purposes in
whatever way they want.  So having the interface use the slot number
is fine; just as having alternative interfaces that don't need to
specify the slot number for the kind of usage that Linux does is also
fine.

Paul.
