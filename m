Message-ID: <3E6D2AEC.5040409@mvista.com>
Date: Mon, 10 Mar 2003 16:16:44 -0800
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: Debbie Xu <DXu@intrinsyc.com>
Cc: "'Linuxppc-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux-Support for IBM PPC405EP's EMACs
References: <FF4C56C7B8A3D41183FA000629D5CCAC020F68F0@cougar.intrinsyc.com>
In-Reply-To: <FF4C56C7B8A3D41183FA000629D5CCAC020F68F0@cougar.intrinsyc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Debbie Xu wrote:
> Hi Todd,
>
> I found some confusing code for the PPC405EP's EMACs at the Linux kernel
> (2.4.21-pre2). It is common to both EMACs.
>
> When the system is booting up, the ocp_enet_open() (in
> drivers/net/ibm_ocp/ibm_ocp_enet.c) is called to open the 2 EMACs, one
> at a time. However, the link status of the Ethernet ports, when it is
> reported in the function mii_display_status() (in
> drivers/net/ibm_ocp/ibm_ocp_phy.c),is controlled by a "link" variable in
> an ocp_enet_private structure. Once a PHY is found at the probing time,
> this "link" variable stays as "1" ("up" status) always. BUT, it doesn't
> care if that Ethernet port is connected to any network or not. This
> "link" status only reflects whether this EMAC is connected to a PHY
> device or not. The definition of the ocp_enet_private structure (at
> drivers/net/ibm_ocp/ibm_ocp_enet.h) doesn't tell much of the nature of
> the"link" variable either. So, what shall we expect from this status
> reporting? I tend to think that a link is only "up" when it's connected
> on a network.
>
> Can you share your ideas on this?

Hi, the code in question predates the recent 405EP changes, and I
haven't looked at it recently.  I have noticed that the link status for
uncabled EMACs was defaulted to "up" (and with other values such as 10BT
half-duplex).  There's a rewrite of this driver in the works so maybe
all this will change soon, otherwise it's something to be cleaned up
someday.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
