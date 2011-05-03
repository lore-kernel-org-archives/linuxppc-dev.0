Return-Path: <B07421@freescale.com>
Date: Tue, 3 May 2011 10:19:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Hollis Blanchard <hollis_blanchard@mentor.com>
Subject: Re: [PATCH 2/2] powerpc: add support for MPIC message register API
Message-ID: <20110503101921.45f31d34@schlenkerla.am.freescale.net>
In-Reply-To: <4DBED5E9.2070201@mentor.com>
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>
	<1303232375-25014-3-git-send-email-meador_inge@mentor.com>
	<071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>
	<4DBAED5D.4060906@mentor.com>
	<071A08F2C6A57E4E94D980ECA553F8741967EC@039-SN1MPN1-004.039d.mgd.msft.net>
	<20110429123051.4ed1ca01@schlenkerla.am.freescale.net>
	<071A08F2C6A57E4E94D980ECA553F8741984EE@039-SN1MPN1-004.039d.mgd.msft.net>
	<4DBED5E9.2070201@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Meador Inge <meador_inge@mentor.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Kushwaha Prabhakar-B32579 <B32579@freescale.com>,
	"openmcapi-dev@googlegroups.com" <openmcapi-dev@googlegroups.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2 May 2011 09:03:53 -0700
Hollis Blanchard <hollis_blanchard@mentor.com> wrote:

> On 05/01/2011 08:41 PM, Kushwaha Prabhakar-B32579 wrote:
> >> Perhaps an allocator could be added in the same patchset that adds such a
> >> user.
> > Yaa. It can be done. Otherwise module has to query each message unit for its availability.
> 
> No, instead the system designer should pick one. If it doesn't matter 
> which one, then the designer is free to pick any.

We should avoid resorting to the notion of a "system designer" if possible
-- it's hard to avoid it when dealing with partitioning, but it shouldn't
be needed for unpartitioned basic driver operation.

> An allocator can't work if you're going to mix drivers. For example, 
> driver A needs MSRG0, and driver B doesn't care. Driver B loads first, 
> the allocator selects MSGR0; driver A loads and fails. Having an 
> allocator at all will create this conflict.

In the absence of partitioning, no driver should need a specific one.  With
partitioning, let the system designer mark those resources as reserved so
they don't get allocated. :-)

-Scott
