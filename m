Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfNVT47rGzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 22:16:33 +1000 (AEST)
Message-ID: <1496405473.2842.9.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc/mm: split store_updates_sp() in two parts
 in do_page_fault()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Scott Wood
 <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 02 Jun 2017 22:11:13 +1000
In-Reply-To: <6daf8f4e-9b39-d585-2c64-9b0348fef123@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
 <871sr23flh.fsf@concordia.ellerman.id.au>
 <6daf8f4e-9b39-d585-2c64-9b0348fef123@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-02 at 11:39 +0200, Christophe LEROY wrote:
> The difference between get_user() and __get_user() is that get_user() 
> performs an access_ok() in addition.
> 
> Doesn't access_ok() only checks whether addr is below TASK_SIZE to 
> ensure it is a valid user address ?

Do you have a measurable improvement by skipping that check ? I agree
with your reasoning but I'm also paranoid and so I wouldn't change it
unless it's really worth it.

Cheers,
Ben.
