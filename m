Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C464B7CF9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 02:55:31 +1100 (EST)
In-Reply-To: <OF788A7534.456B03AA-ON882576F6.00228BC4-882576F6.00233EC1@selinc.com>
References: <OF788A7534.456B03AA-ON882576F6.00228BC4-882576F6.00233EC1@selinc.com>
Subject: Re: Question regarding the DTLB Miss exceptions
To: Bruce_Leonard@selinc.com
Message-ID: <OF1F3D1670.795F8C23-ONC12576F7.00565EBF-C12576F7.00568397@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 31 Mar 2010 17:44:57 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org,
	linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> I'm tracking a problem that's leading me through DSI and DTLB miss
> exceptions on an MPC8347 (e300c1 core), and I've come across an oddity
> that I'm hoping someone can explain.
>
> When a DTLB Miss exception can't find a PTE for the virtual address being
> written/read, it dummies up the SPRs for a DSI exception and then calls
> directly into the DSI exception code.  Just before the DTLB miss code
> stores a value into DSISR it sets bit 2, which for a DSI exception is a
> reserved bit and should be cleared.  There's no comment on the code
> (.../arch/powerpc/kernel/head_32.S line 619 of the 2.6.33-rc1 kernel). Can
> anyone tell me why this bit is getting set?

Probably for generic handling in do_page_fault()

  Jocke
