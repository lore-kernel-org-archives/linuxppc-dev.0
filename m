Message-ID: <3F38DEC4.8050708@imc-berlin.de>
Date: Tue, 12 Aug 2003 14:34:12 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Brad Parker <brad@parker.boston.ma.us>
Subject: Re: Questions about ARP
References: <3F33BC10.8060407@imc-berlin.de> <3F33EADE.4010908@embeddededge.com>
In-Reply-To: <3F33EADE.4010908@embeddededge.com>
Content-Type: multipart/mixed;
 boundary="------------030301040909050603050005"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------030301040909050603050005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dan Malek wrote:

 > Steven Scholz wrote:
 >
 >> But when I connect my MPC8xx board with Linux it seems that Linux is
 >> not responding to the ARP requests done by the Windows machine.
 >> Result: Both machine end up with the same IP address.
 >
 >
 > Fortunately, Linux isn't Windows......you are going to find lots of
 > Windows "standard" protocols that aren't documented nor supported by
 > anyone else.
 >
 >> Did I miss something?
 >
 >
 > Well, Microsoft did.....there is RFC2131 that describes how you are
 > supposed to use an ARP to respond to a duplicate IPv4 used on the
 > network.  It is commonly used to ensure you don't have systems
 > manually configured or not honoring leases when DHCP is handing out
 > dynamic IP addresses.  Everyone else seems to implement this properly.

Finaly I found the point you're talking about.
Linux is answering the ARP packets with Source Address 0.0.0.0 (see net/ipv4/arp.c):

         /* Special case: IPv4 duplicate address detection packet (RFC2131) */
         if (sip == 0) {
                 if (arp->ar_op == htons(ARPOP_REQUEST) &&
                     inet_addr_type(tip) == RTN_LOCAL)
                         arp_send(ARPOP_REPLY,ETH_P_ARP,tip,dev,tip,sha,dev->dev_addr,dev->dev_addr);
                 goto out;
         }

Windows is checking for duplicate addresses using ARP packets with source _and_
destination address set to the address in question. So of course Linux won't answer it!

But I can't find a single word in the RFC2131 (http://www.faqs.org/rfcs/rfc2131.html)
saying that the Source Address _must_ set to 0.0.0.0!!!!

So the attached patch will make M$ Windows happy and APIPA working.

Thanks,

Steven

--------------030301040909050603050005
Content-Type: text/plain;
 name="linux-2.4.20-APAPI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.20-APAPI.patch"

+ diff -u ./net/ipv4/arp.c.APAPI ./net/ipv4/arp.c
--- ./net/ipv4/arp.c.APAPI	Tue Aug 12 13:00:59 2003
+++ ./net/ipv4/arp.c	Tue Aug 12 14:32:40 2003
@@ -760,6 +760,18 @@
 		goto out;
 	}

+#define MAKE_MS_WINDOWS_HAPPY
+#ifdef MAKE_MS_WINDOWS_HAPPY
+	/* Special case: IPv4 duplicate address detection packet (MS Windows) */
+	if (inet_addr_type(sip) == RTN_LOCAL) {
+		printk("ARP: IPv4 duplicate address detection packet (MS Windows)\n");
+		if (arp->ar_op == htons(ARPOP_REQUEST) &&
+		    inet_addr_type(tip) == RTN_LOCAL)
+			arp_send(ARPOP_REPLY,ETH_P_ARP,tip,dev,tip,sha,dev->dev_addr,dev->dev_addr);
+		goto out;
+	}
+#endif
+
 	if (arp->ar_op == htons(ARPOP_REQUEST) &&
 	    ip_route_input(skb, tip, sip, 0, dev) == 0) {


--------------030301040909050603050005--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
