Message-ID: <39739185.51ADF2F7@m2tech.co.nz>
Date: Tue, 18 Jul 2000 11:06:45 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: xuwentao@cn.ibm.com
CC: mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why eth0 does not work
References: <4825691F.002DF1CC.00@d73mta06.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


xuwentao@cn.ibm.com wrote:

>
> the output of the tcpdump -i eth0 host 7.1.1.5 in the NFS server is:
> 13:47:08.224173 B arp who-has 7.1.1.21 tell 7.1.1.5
> 13:47:08.224207 > arp reply 7.1.1.21 (0:20:35:b1:fc:d8) is-at
> 0:20:35:b1:fc:d8 (
> 12:34:56:78:90:ab)
> 13:47:09.335805 B arp who-has 7.1.1.21 tell 7.1.1.5
> 13:47:09.335826 > arp reply 7.1.1.21 (0:20:35:b1:fc:d8) is-at
> 0:20:35:b1:fc:d8 (
> 12:34:56:78:90:ab)
> 13:47:10.447399 B arp who-has 7.1.1.21 tell 7.1.1.5
> 13:47:10.447413 > arp reply 7.1.1.21 (0:20:35:b1:fc:d8) is-at
> 0:20:35:b1:fc:d8 (
> 12:34:56:78:90:ab)
> 13:47:13.604779 B arp who-has 7.1.1.21 tell 7.1.1.5
> 13:47:13.604794 > arp reply 7.1.1.21 (0:20:35:b1:fc:d8) is-at
> 0:20:35:b1:fc:d8 (
> 12:34:56:78:90:ab)
> .......
> I also tried other vlaues for the buffer registers such as
> page start reg: 0
> current page reg: 1
> page stop reg: 32
> boundary poiter: 0
> and also got rx errors. I dont know what to do next.
>
> Wentao
>

okay... well i'm not sure what patches you are using, but as i recall
montavista did not use grant's latest kernel patch with a very major (but very
small :) ethernet fix..

in the drivers/net/oaknet.c file please check the function
oaknet_get_8390_hdr().. at the end of this function make sure you have the
following code segment (the byte swap is the changed line):

---------------
else
    ei_isb(E8390_BASE + E8390_DATA, hdr,
                sizeof(struct e8390_pkt_hdr));

/* byte swap the packet byte count */

hdr->count = le16_to_cpu(hdr->count);

ei_obp(ENISR_RDC, base + EN0_ISR);    /* ACK Remote DMA interrupt */
ei_status.dmaing &= ~0x01;

return;
----------------

let me know if this helps..

cheers,
ben

--
/\\------------------------------------------------------------------
:::::::::::..ben.b..m2technologyltd.nz..64.9.4448307.130..:::::::::::


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
