Return-Path: <dave.mccracken@oracle.com>
Received: from ms-smtp-04.texas.rr.com (ms-smtp-04.texas.rr.com [24.93.47.43])
	by ozlabs.org (Postfix) with ESMTP id A3FCBDDE9C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 09:32:03 +1000 (EST)
From: Dave McCracken <dave.mccracken@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pte_offset_map for ppc assumes HIGHPTE
Date: Wed, 25 Jul 2007 18:30:21 -0500
References: <acbcf3840707251516w301f834cj5f6a81a494d359ed@mail.gmail.com>
	<jewswodqcn.fsf@sykes.suse.de>
	<1185405765.5439.371.camel@localhost.localdomain>
In-Reply-To: <1185405765.5439.371.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707251830.21944.dave.mccracken@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 July 2007, Benjamin Herrenschmidt wrote:
> Depends... if you have CONFIG_HIGHMEM and not CONFIG_HIGHPTE, you are
> wasting time going through kmap_atomic unnecessarily no ? it will probably
> not do anything because the PTE page is in lowmem but still...

Probably not much time.  You still need to do the page to virtual translation, 
which kmap_atomic does for you.

Dave McCracken
