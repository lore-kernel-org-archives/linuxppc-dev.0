Return-Path: <timur@freescale.com>
Message-ID: <471F75A1.1000909@freescale.com>
Date: Wed, 24 Oct 2007 11:41:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Audio codec device tree entries
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>	
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>	
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>	
	<471F52ED.10007@freescale.com>	
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>	
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>	
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>	
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>	
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>	
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
	<fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>
In-Reply-To: <fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Now is probably a good time to mention that there is *nothing* in the
> device tree that enforces a 1:1 relationship between device tree nodes
> and driver instances.  Sure, it make sense to register the i2s and
> codec drivers from probing on the i2s and codec nodes.  However, there
> is nothing that prevents the codec driver from *also* registering a
> fabric driver based on a property in the codec node or the board-level
> compatible property.

Wouldn't it make more sense for the fabric driver to register the codec driver? 
  The fabric driver is the "master" of the other drivers, should it needs to 
load and run first.

> Fabric drivers are codec specific anyway.

Yes and no.  They're really platform-specific, but they should be able to scan 
the device tree, determine which codecs are actually on the system, and then 
link in the appropriate codec driver.
