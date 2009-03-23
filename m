Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <200903231151.10373.sr@denx.de>
References: <200903231151.10373.sr@denx.de>
Date: Mon, 23 Mar 2009 09:37:31 -0600
Message-ID: <fa686aa40903230837w52a9f764n29b3f9cf4c95cc57@mail.gmail.com>
Subject: Re: physmap_of and partitions (mtd concat support)
From: Grant Likely <grant.likely@secretlab.ca>
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 23, 2009 at 4:51 AM, Stefan Roese <sr@denx.de> wrote:
> I just noticed that physmap_of can't handle multiple devices of different type
> described in one device node. For example the Intel P30 48F4400 (64MByte)
> consists internally of 2 non-identical NOR chips. So a "simple"
[...]
> Now the real problem: How should I describe a partition in the device tree
> spanning over both devices (concat)?. The current physmap_of driver doesn't
> handle concat at all (physmap.c does). I already have some ideas on how to
> implement this concat support in physmap_of. But ideas about a device-tree
> syntax for such partitions are very welcome.

Sounds to me like a physmap_of driver bug.  I don't think there is any
advantage in changing the partition syntax since concatenated flash
will always be used as a single device.  It doesn't make any sense to
try and span partitions over two nodes.

Do additional properties need to be added to describe the concat layout?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
