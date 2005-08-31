Return-Path: <mgreer@mvista.com>
Date: Tue, 30 Aug 2005 18:29:40 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050831012940.GA3276@mag.az.mvista.com>
References: <20050830233851.GA29529@mag.az.mvista.com>
	<d561d896950ba7adde6b93c1a2bba272@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d561d896950ba7adde6b93c1a2bba272@embeddededge.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: Remove progress msgs from MMU_init()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2005 at 09:09:55PM -0400, Dan Malek wrote:
> 
> On Aug 30, 2005, at 7:38 PM, Mark A. Greer wrote:
> 
> >Does anyone object to this patch?
> 
> Don't you still need this to run stuff like xmon and kgdb?

Those should work with just an io_block_mapping() which will be active
before setup_arch() calls xmon() and breakpoint().

The problem with progress msgs in MMU_init() is that they try to bang on
the uart before ioremaps/io_block_mappings are active.  That's why I (and
others) had the xxx_set_bat() hack.

Mark
