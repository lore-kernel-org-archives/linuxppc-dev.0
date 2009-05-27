Return-Path: <joakim.tjernlund@transmode.se>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208934920A@zch01exm21.fsl.freescale.net>
References: <D7CCA83BB0796C49BC0BB53B6AB1208934920A@zch01exm21.fsl.freescale.net>
Subject: Re: Net: ucc_geth ethernet driver optimization space
To: "Liu Dave-R63238" <DaveLiu@freescale.com>
Message-ID: <OFED0E4273.051DFDD2-ONC12575C3.00246ED3-C12575C3.0025759F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 27 May 2009 08:49:09 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org wrote on 27/05/2009 07:08:07:
>
> Guys,
>
> The ucc_geth ethernet driver have dozens of strong sync read/write
> operation, such as in_be32/16/8, out_be32/16/8.
>
> all of them is sync read/write, it is very expensive for performance.
>
> For the critical patch, we can remove some unnecessary in_be(x),
> out_be(x) with normal memory operation, and keep some necessary
> memory barrier.
>
> eg: BD access in the interrupt handler and start_xmit.
>
> The BD operation only need the memory barrier between length/buffer
> and status.
>
> struct buffer descriptor {
>    u16 status;
>    u16 length;
>    u32 buffer;
> } __attribute__ ((packed));
>
> struct buffer descriptor *BD;
>
> BD->length = xxxx;
> BD->buffer = yyyy;
> wmb();
> BD->status = zzzz;
>
> For powerpc, eieio is enough for 60x, mbar 1 is enough for e500.
> Of couse, also need the memory clobber to avoid the compiler
> reorder between them.
>
> Thanks, Dave

Yes, pretty please :)

You might want to combine status and length into one U32 though:
BD->buffer = yyyy;
wmb();
BD->stat_len = zzzz << 16 | xxxx;

  Jocke
