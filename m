In-Reply-To: <20040614084625.A29057@home.com>
References: <1087207803.7360.83.camel@newt> <20040614084625.A29057@home.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5F4101CA-BE64-11D8-ACA7-000393DBC2E8@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH][RFC] OCP support for MPC107 and relatives
Date: Mon, 14 Jun 2004 19:38:51 -0500
To: Matt Porter <mporter@kernel.crashing.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

We know have several systems which have the same issue of updating a
paddr based on some offset.

I'm wondering if we should add something like the following code into
ocp.c (obviously, removing the 85xx specific aspects).

Called w/in board code:

         ocp_for_each_device(mpc85xx_update_paddr_ocp,
&(binfo->bi_immr_base));

Or should we have a more explicit ocp_update_paddr(phys_addr_t x);

/*
************************************************************************
  */
/* Update the 85xx OCP tables paddr field */
void
mpc85xx_update_paddr_ocp(struct ocp_device *dev, void *arg)
{
         phys_addr_t ccsrbar;
         if (arg) {
                 ccsrbar = *(phys_addr_t *)arg;
                 dev->def->paddr += ccsrbar;
         }
}

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
