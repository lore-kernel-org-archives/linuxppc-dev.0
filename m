Return-Path: <kou.ishizaki@toshiba.co.jp>
Date: Wed, 26 Dec 2007 20:42:16 +0900 (JST)
Message-Id: <20071226.204216.-1300525659.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: Time for cell code reshuffle?
In-Reply-To: <1198357215.6686.8.camel@pasglop>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	arnd@arndb.de, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Fri, 2007-12-21 at 20:15 +0100, Arnd Bergmann wrote:
> > > It seems platforms/cell should have the shared and/or generic code,
> > and the other
> > > stuff moved into a new platform directory, but is it worth the
> > effort? 
> > 
> > There is very little code in platforms/cell that can not be generic,
> > so I think
> > it's not worth splitting it. The only IBM blade specific files are
> > cbe_cpufreq_pmi.c and parts of setup.c and pervasive.c. Everything
> > else could
> > be shared by about any generic implementation without a hypervisor.
> 
> Another option is to have:
> 
> platforms/celleb -> platforms/beat
> 
> and withing platforms/cell, rename blade specific files to
> something (can't find what, works on CAB too) and add celleb
> "bare metal" files.
> 
> A platform directly doesn't have to deal with one platform. For example,
> platforms/44x contains a lot of board support.
> 
> Now, one question is how far can we merge celleb support with the common
> blade/CAB code...

Celleb-native needs own machine definition and setup code due to HW
and FW deferences between CellBlade and Celleb. Of course, because
Celleb-native and Celleb-Beat use some codes commonly, we need a place
to put Celleb common codes.

But I don't know your idea is better or not.

Best regards,
Kou Ishizaki
