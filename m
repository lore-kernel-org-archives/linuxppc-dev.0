Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41CmF43vTHzF14Y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 05:47:52 +1000 (AEST)
Date: Sat, 23 Jun 2018 14:47:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Mathieu Malaterre <malat@debian.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Yisheng Xie <xieyisheng1@huawei.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xmon: =?utf-8?Q?avoid_?=
 =?utf-8?Q?warnings_about_variables_that_might_be_clobbered_by_=E2=80=98lo?=
 =?utf-8?B?bmdqbXDigJk=?=
Message-ID: <20180623194716.GY16221@gate.crashing.org>
References: <20180622192718.24242-1-malat@debian.org>
 <b41b244e-78b8-c85f-9122-427ad04cccf8@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b41b244e-78b8-c85f-9122-427ad04cccf8@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 23, 2018 at 06:59:27PM +0200, christophe leroy wrote:
> 
> 
> Le 22/06/2018 à 21:27, Mathieu Malaterre a écrit :
> >Move initialization of variables after data definitions. This silence
> >warnings treated as error with W=1:
> >
> >   arch/powerpc/xmon/xmon.c:3389:14: error: variable ‘name’ might be 
> >   clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
> >   arch/powerpc/xmon/xmon.c:3100:22: error: variable ‘tsk’ might be 
> >   clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
> 
> Is that an invalid warning ?

No, both are correct warnings.  GCC can not see which functions it only
has a declaration of can call longjmp.

> Otherwise, I'd expect one to fix the warning, not just cheat on GCC.

Yes, the patch seems to change the code in such a way that some versions
of GCC will no longer warn.  Which does not make to code any more correct.

Either restructure the code, or make the var non-automatic, or make it
volatile.


Segher
