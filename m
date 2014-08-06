Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DE371A0872
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 09:12:17 +1000 (EST)
Message-ID: <1407366736.8507.35.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc: thp: Use tlbiel wherever possible
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 07 Aug 2014 09:12:16 +1000
In-Reply-To: <8738d965hf.fsf@linux.vnet.ibm.com>
References: <1407221289-19390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <8738d965hf.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-06 at 20:16 +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>=20
> > If we know that user address space has never executed on other cpus
> > we could use tlbiel.
> >
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>=20
> Now checking against flush_hash_page, I am wondering whether I need to ha=
ndle
> transcational memory in case of tlbiel ? Michael, can you let me know if
> this is needed ?

Yeah, you do need to add something. =20

local tlbie won't abort the transaction (broadcast will abort), so you
need to do a explicit tabort if there is an active transaction, to make
sure the transaction is doomed.

Mikey
