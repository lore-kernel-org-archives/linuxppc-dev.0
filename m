Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@free.fr>
In-Reply-To: <41CEC6B0.5020106@free.fr>
References: <41CEC6B0.5020106@free.fr>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 09:50:05 +0100
Message-Id: <1104137405.5615.17.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PATCH uninorth3 (G5) agp support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +	if((uninorth_rev >= 0x30) && (uninorth_rev <= 0x33)) {
> +		/*
> +		 * We need to to set REQ_DEPTH to 7 for U3 versions 1.0, 2.1,
> +		 * 2.2 and 2.3, Darwin do so.
> +		 */
> +		command |= (7 << AGPSTAT_RQ_DEPTH_SHIFT);
> +	}
>  

Some revs of U3 (3.x) do have some high bits sets in the version
register, you should probably mask it with 0x3f ... Though on the other
hand, I don't know if revisions prior to 3.x were ever used on
production...

Ben.
