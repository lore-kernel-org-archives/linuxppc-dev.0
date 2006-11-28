Return-Path: <lukebr@linux.vnet.ibm.com>
Subject: Re: [POWERPC 2/9] spufs: always send sigtrap on breakpoint
From: Luke Browning <lukebr@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20061127182429.882511000@arndb.de>
References: <20061127181851.796747000@arndb.de>
	<20061127182429.882511000@arndb.de>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 22:12:15 -0200
Message-Id: <1164672736.3683.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ulrich Weigand <ulrich.weigand@de.ibm.com>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-27 at 19:18 +0100, Arnd Bergmann wrote:
> plain text document attachment
> (spufs-always-sigtrap-on-breakpoint.diff)
> Currently, we only send a sigtrap if the current task is being ptraced.
> This is somewhat inconsistant, and it breaks utrace support in fedora.
> Removing the check should do the right thing in all cases.
> 
> Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> 
> diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
> index 1be4e33..1acc2ff 100644
> --- a/arch/powerpc/platforms/cell/spufs/run.c
> +++ b/arch/powerpc/platforms/cell/spufs/run.c
> @@ -350,12 +350,10 @@ out2:
>  	       (status >> SPU_STOP_STATUS_SHIFT != 0x2104)))))
>  		ret = status;
> 
> -	if (unlikely(current->ptrace & PT_PTRACED)) {
> -		if ((status & SPU_STATUS_STOPPED_BY_STOP)
> -		    && (status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
> -			force_sig(SIGTRAP, current);
> -			ret = -ERESTARTSYS;
> -		}
> +	if ((status & SPU_STATUS_STOPPED_BY_STOP)
> +	    && (status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
> +		force_sig(SIGTRAP, current);
> +		ret = -ERESTARTSYS;
>  	}
> 
>  out:
> 

Arnd, could you explain this change a little bit more.  Don't you have
to consider whether the program is setup to receive SIGTRAP.  We know it
is code to handle SIGTRAP if it is ptraced.  Or, are you asserting that
at this point the spu has hit a trap instruction?  What does 0x3fff
mean?

Luke
