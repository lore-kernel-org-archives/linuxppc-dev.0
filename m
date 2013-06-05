Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 5B8252C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 01:42:49 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 27232-07 for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  5 Jun 2013 16:42:43 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH -V10 10/15] powerpc: Prevent gcc to re-read the pagetables
Date: Wed, 5 Jun 2013 16:41:45 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7271@saturn3.aculab.com>
In-Reply-To: <1370446119-8837-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1370446119-8837-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 <benh@kernel.crashing.org>, <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>  	ptep =3D pte_offset_kernel(&pmd, addr);
>  	do {
> -		pte_t pte =3D *ptep;
> +		pte_t pte =3D ACCESS_ONCE(*ptep);

Why not just define ptep as a 'pointer to volatile'?

	David
