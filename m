Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 05C2F686FA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Nov 2005 06:35:19 +1100 (EST)
Date: Fri, 11 Nov 2005 11:35:16 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Greg Weeks <greg.weeks@timesys.com>
Message-ID: <20051111193516.GA31237@gate.ebshome.net>
References: <331697990.25627@st.lzu.edu.cn> <437493D3.2070301@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437493D3.2070301@timesys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: floating point operation of ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Nov 11, 2005 at 07:51:31AM -0500, Greg Weeks wrote:
> lily wrote:
> 
> > hi,all:
> > i build an embedded linux on powerpc 405ep,i need execute floating
> > point operation,and i enable "math emulate" option in kernel, i run a
> > while(1)loop ,in the loop there was floating point expression ,after
> > test ,i found the while (1) exit because of the floating point
> > computation,that is the floating point can't execute on ppc
> > stablely.Is there someone meets the same problems ,please give me some
> > suggestion,thanks!!!
> 
> The 405ep has some errata on floating point use. 

Are you sure it was 405ep? There is no floating point errata for this 
chip due to the simple reason, it doesn't support floating point in 
hardware at all.

You probably confusing it with 440ep.

I'm not aware of any 405ep specific toolchain. In fact, all what is 
needed is simple 4xx specific toolchain with soft-float enabled by 
default. This is how floating point is usually done for 4xx - just soft 
emulation in user-space by the compiler without in-kernel emulation, 
which is slow.

-- 
Eugene
