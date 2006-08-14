Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id ED2EE67BC0
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 21:27:09 +1000 (EST)
Date: Mon, 14 Aug 2006 13:26:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
Message-ID: <20060814112656.GC10164@wohnheim.fh-wedel.de>
References: <44D99EFC.3000105@de.ibm.com> <20060811205624.GE479@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20060811205624.GE479@krispykreme>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 12 August 2006 06:56:24 +1000, Anton Blanchard wrote:
> 
> > +
> > +				skb_index = ((index - i
> > +					      + port_res->skb_arr_sq_len)
> > +					     % port_res->skb_arr_sq_len);
> 
> This is going to force an expensive divide. Its much better to change
> this to the simpler and quicker:
> 
> i++;
> if (i > max)
> 	i = 0;

Is a conditional cheaper than a divide?  In case of a misprediction I
would assume it to be significantly slower and I don't know the ratio
of mispredictions for this branch.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
