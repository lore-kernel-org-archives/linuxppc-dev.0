Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 08F27DDF48
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 01:10:24 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org,
 rmcguire@videopresence.com
Subject: Re: HDLC driver - dev_free_skb_irq causes Segfault
Date: Wed, 13 Feb 2008 15:11:06 +0100
References: <00be01c86b8d$27c2fcb0$6405a8c0@absolut>
In-Reply-To: <00be01c86b8d$27c2fcb0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1730726.7p3cYmlR7V";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802131511.06929.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1730726.7p3cYmlR7V
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Russ,

On Sunday 10 February 2008 03:32, Russell McGuire wrote:
> All,
>
> So I am in the process of debugging my newly established HDLC driver.
> More or less modeled after a simplified gianfar / ucc_geth idea.
>
> However, after loading, etc. and using the following commands
>
> -> insmod hdlc-8360.ko
> -> sethdlc hdlc0 hdlc-eth
> -> ifconfig hdlc0 up 192.168.1.100
>
> All is well, and I am seeing IDL interrupts. Great.
>
> Now I go to ping an address like,
> ping 192.168.1.101
>
> I can see that I get the start_xmit function, the IRQ from the QE comes
> back and reports the TXBD as successfully sent.
>
> Here is the problem, when I goto free the skb in the tx_handler, I get a
> 'Unable to Handle Kernel Paging Request for data at address 0x00000000'
> Even though for the life of me, I can't see any pointers that are at
> address zero.

I'm experiencing a similar problem here with a in-house HDLC driver. The=20
kernel oopses after some time under high HDLC loads.

Could you please post a backtrace to see if our problems are related ? How =
do=20
you free the skb ? Posting code snippet (or even the whole source code) wou=
ld=20
help.

> I have checked the pointer value I am passing in, and indeed it is the
> exact same pointer I am receiving from the original
> start-xmit call..
>
> Are we supposed to copy the skb? And free it immediately in the start_xmi=
t?
> Some special way to store the pointer?

My understanding is that the skb is supposed to be freed in the TX interrup=
t=20
handler.

> I have tried
> txbd->buf =3D skb->data;
> txbd->buf =3D virt_to_phys(skb->data);
> etc.. and various other ways to save that I have seen in  the gianfar and
> ucc_geth drivers.

You should map the skb data buffer using dma_map_single. Don't forget to un=
map=20
it with dma_unmap_single in the TX interrupt handler.

> My tx_sk_buff** is identical as alloced the same way.
>
> Anyone have any ideas?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1730726.7p3cYmlR7V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHsvp68y9gWxC9vpcRAqGBAJ9jcE8sKPTkJklKaZC74L4Ail5ImACdHfC2
1HFyfR4OAZE0rpmsQu+lOkM=
=GrDj
-----END PGP SIGNATURE-----

--nextPart1730726.7p3cYmlR7V--
