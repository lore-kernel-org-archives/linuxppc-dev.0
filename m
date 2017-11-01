Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRwc36Y4SzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 04:45:38 +1100 (AEDT)
Date: Wed, 1 Nov 2017 18:17:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
Subject: Re: [PATCH FEAT] ibmvnic: Feature implementation of Vital Product
 Data (VPD) for the ibmvnic driver
Message-ID: <20171101171708.GA24320@lunn.ch>
References: <20171101143959.14992-1-desnesn@linux.vnet.ibm.com>
 <b216c469-f090-e3b5-aaa4-16295db01eb4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b216c469-f090-e3b5-aaa4-16295db01eb4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> > index d0cff28..120f3c0 100644
> > --- a/drivers/net/ethernet/ibm/ibmvnic.c
> > +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> > @@ -107,6 +107,9 @@ static union sub_crq *ibmvnic_next_scrq(struct ibmvnic_adapter *,
> >  					struct ibmvnic_sub_crq_queue *);
> >  static int ibmvnic_poll(struct napi_struct *napi, int data);
> >  static void send_map_query(struct ibmvnic_adapter *adapter);
> > +static int ibmvnic_get_vpd(struct ibmvnic_adapter *);
> > +static void handle_vpd_size_rsp(union ibmvnic_crq *, struct ibmvnic_adapter *);
> > +static void handle_vpd_rsp(union ibmvnic_crq *,struct ibmvnic_adapter *);
> 
> There should be a space after the comma.

And you should try to avoid forward declarations. Move the code around
so they are not needed.

   Andrew
