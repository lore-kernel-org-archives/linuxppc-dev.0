Return-Path: <misbah_khan@engineer.com>
Received: from fallback.us4.outblaze.com (fallback.us4.outblaze.com
	[205.158.62.120]) by ozlabs.org (Postfix) with ESMTP id 080C0DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 19:47:31 +1000 (EST)
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by fallback.us4.outblaze.com (Postfix) with ESMTP id C07C21C0A7BB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 09:19:22 +0000 (GMT)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	1BA1F18001AA for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 09:19:13 +0000 (GMT)
Content-Type: multipart/alternative; boundary="_----------=_118526875242070"
MIME-Version: 1.0
From: "misbah khan" <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 24 Jul 2007 04:19:12 -0500
Subject: Re: Linuxppc-embedded Digest, Vol 35, Issue 51
Message-Id: <20070724091912.98B0C478077@ws1-5.us4.outblaze.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--_----------=_118526875242070
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Can you please check the data format . PPC works on BigEndian format.
Please do this and let me know ....  --- misbah

  ----- Original Message -----
  From: linuxppc-embedded-request@ozlabs.org
  To: linuxppc-embedded@ozlabs.org
  Subject: Linuxppc-embedded Digest, Vol 35, Issue 51
  Date: Tue, 24 Jul 2007 12:00:02 +1000


  Send Linuxppc-embedded mailing list submissions to
  linuxppc-embedded@ozlabs.org

  To subscribe or unsubscribe via the World Wide Web, visit
  https://ozlabs.org/mailman/listinfo/linuxppc-embedded
  or, via email, send a message with subject or body 'help' to
  linuxppc-embedded-request@ozlabs.org

  You can reach the person managing the list at
  linuxppc-embedded-owner@ozlabs.org

  When replying, please edit your Subject line so it is more specific
  than "Re: Contents of Linuxppc-embedded digest..."


  Today's Topics:

  1. Re: Gdbserver syscall clobber (Andreas Schwab)
  2. Re: Kmalloc returns which address (Scott Wood)
  3. Re: [Bugme-new] [Bug 8778] New: Ocotea board: kernel reports
  access of bad area during boot with DEBUG_SLAB=3Dy (Christoph Lameter)


  ----------------------------------------------------------------------

  Message: 1
  Date: Mon, 23 Jul 2007 18:19:37 +0200
  From: Andreas Schwab
  Subject: Re: Gdbserver syscall clobber
  To: Bill Gatliff
  Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
  Message-ID:
  Content-Type: text/plain; charset=3Diso-8859-1

  Bill Gatliff writes:

  > Daniel Jacobowitz wrote:
  >> On Wed, Jul 18, 2007 at 12:59:42PM -0500, Bill Gatliff wrote:
  >>
  >>> Now, I'm a little rusty on PPC asm (I've been doing a lot of ARM
  >>> lately), but it looks to me like the kernel is setting bit 0 in
  CR0
  >>> (oris r10, r10, 0x1000) a.k.a LT, but the user side is looking at
  CR0
  >>> (bnslr+) bit 3 a.k.a. SO.

  Bits are numbered from left to right, thus 0x10000000 is bit 3 of CR0

  Andreas.

  --
  Andreas Schwab, SuSE Labs, schwab@suse.de
  SuSE Linux Products GmbH, Maxfeldstra?e 5, 90409 N?rnberg, Germany
  PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756 01D3 44D5 214B 8276
  4ED5
  "And now for something completely different."


  ------------------------------

  Message: 2
  Date: Mon, 23 Jul 2007 13:35:11 -0500
  From: Scott Wood
  Subject: Re: Kmalloc returns which address
  To: Misbah khan
  Cc: linuxppc-embedded@ozlabs.org
  Message-ID: <20070723183510.GA29223@ld0162-tx32.am.freescale.net>
  Content-Type: text/plain; charset=3Dus-ascii

  On Sun, Jul 22, 2007 at 08:47:47PM -0700, Misbah khan wrote:
  > yes really it would really generate a machine check... but i guess
  if you
  > convert this virt address to physical address using __pa() then
  pass it to
  > the ioremap() i guess things will work .

  What would be the point? All you'd get is another virtual mapping.

  Is the DMA mapping API that difficult?

  -Scott


  ------------------------------

  Message: 3
  Date: Mon, 23 Jul 2007 13:34:50 -0700
  From: Christoph Lameter
  Subject: Re: [Bugme-new] [Bug 8778] New: Ocotea board: kernel reports
  access of bad area during boot with DEBUG_SLAB=3Dy
  To: Andrew Morton
  Cc: netdev@vger.kernel.org, bart.vanassche@gmail.com,
  linux-mm@kvack.org, "bugme-daemon@kernel-bugs.osdl.org"
  , linuxppc-embedded@ozlabs.org
  Message-ID: <20070723133450.3de91b33@schroedinger.engr.sgi.com>
  Content-Type: text/plain; charset=3DUS-ASCII

  On Wed, 18 Jul 2007 09:55:37 -0700
  Andrew Morton wrote:

  > hm. It should be the case that providing SLAB_HWCACHE_ALIGN at
  > kmem_cache_create() time will override slab-debugging's offsetting
  > of the returned addresses.


  That is true for SLUB but not in SLAB. SLAB has always ignored
  SLAB_HWCACHE_ALIGN when debugging is on because of the issues
  involved
  in placing the redzone values etc. Could be fun to fix.



  ------------------------------

  _______________________________________________
  Linuxppc-embedded mailing list
  Linuxppc-embedded@ozlabs.org
  https://ozlabs.org/mailman/listinfo/linuxppc-embedded

  End of Linuxppc-embedded Digest, Vol 35, Issue 51
  *************************************************

--=20
We've Got Your Name at http://www.mail.com!
Get a FREE E-mail Account Today - Choose From 100+ Domains


--_----------=_118526875242070
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<DIV><BR>Can you please check the data format . PPC works on BigEndian form=
at. Please do this and let me know ....</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;--- misbah<BR></DIV>
<BLOCKQUOTE style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #101=
0ff 2px solid">----- Original Message -----<BR>From: linuxppc-embedded-requ=
est@ozlabs.org<BR>To: linuxppc-embedded@ozlabs.org<BR>Subject: Linuxppc-emb=
edded Digest, Vol 35, Issue 51<BR>Date: Tue, 24 Jul 2007 12:00:02 +1000<BR>=
<BR><BR>Send Linuxppc-embedded mailing list submissions to<BR>linuxppc-embe=
dded@ozlabs.org<BR><BR>To subscribe or unsubscribe via the World Wide Web, =
visit<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR>or, via e=
mail, send a message with subject or body 'help' to<BR>linuxppc-embedded-re=
quest@ozlabs.org<BR><BR>You can reach the person managing the list at<BR>li=
nuxppc-embedded-owner@ozlabs.org<BR><BR>When replying, please edit your Sub=
ject line so it is more specific<BR>than "Re: Contents of Linuxppc-embedded=
 digest..."<BR><BR><BR>Today's Topics:<BR><BR>1. Re: Gdbserver syscall clob=
ber (Andreas Schwab)<BR>2. Re: Kmalloc returns which address (Scott Wood)<B=
R>3. Re: [Bugme-new] [Bug 8778] New: Ocotea board: kernel reports<BR>access=
 of bad area during boot with DEBUG_SLAB=3Dy (Christoph Lameter)<BR><BR><BR=
>----------------------------------------------------------------------<BR>=
<BR>Message: 1<BR>Date: Mon, 23 Jul 2007 18:19:37 +0200<BR>From: Andreas Sc=
hwab <SCHWAB@SUSE.DE><BR>Subject: Re: Gdbserver syscall clobber<BR>To: Bill=
 Gatliff <BGAT@BILLGATLIFF.COM><BR>Cc: gdb@sourceware.org, linuxppc-embedde=
d@ozlabs.org<BR>Message-ID: <JEMYXN6QJQ.FSF@SYKES.SUSE.DE><BR>Content-Type:=
 text/plain; charset=3Diso-8859-1<BR><BR>Bill Gatliff <BGAT@BILLGATLIFF.COM=
>writes:<BR><BR>&gt; Daniel Jacobowitz wrote:<BR>&gt;&gt; On Wed, Jul 18, 2=
007 at 12:59:42PM -0500, Bill Gatliff wrote:<BR>&gt;&gt;<BR>&gt;&gt;&gt; No=
w, I'm a little rusty on PPC asm (I've been doing a lot of ARM<BR>&gt;&gt;&=
gt; lately), but it looks to me like the kernel is setting bit 0 in CR0<BR>=
&gt;&gt;&gt; (oris r10, r10, 0x1000) a.k.a LT, but the user side is looking=
 at CR0<BR>&gt;&gt;&gt; (bnslr+) bit 3 a.k.a. SO.<BR><BR>Bits are numbered =
from left to right, thus 0x10000000 is bit 3 of CR0<BR><BR>Andreas.<BR><BR>=
--<BR>Andreas Schwab, SuSE Labs, schwab@suse.de<BR>SuSE Linux Products GmbH=
, Maxfeldstra?e 5, 90409 N?rnberg, Germany<BR>PGP key fingerprint =3D 58CA =
54C7 6D53 942B 1756 01D3 44D5 214B 8276 4ED5<BR>"And now for something comp=
letely different."<BR><BR><BR>------------------------------<BR><BR>Message=
: 2<BR>Date: Mon, 23 Jul 2007 13:35:11 -0500<BR>From: Scott Wood <SCOTTWOOD=
@FREESCALE.COM><BR>Subject: Re: Kmalloc returns which address<BR>To: Misbah=
 khan <MISBAH_KHAN@ENGINEER.COM><BR>Cc: linuxppc-embedded@ozlabs.org<BR>Mes=
sage-ID: &lt;20070723183510.GA29223@ld0162-tx32.am.freescale.net&gt;<BR>Con=
tent-Type: text/plain; charset=3Dus-ascii<BR><BR>On Sun, Jul 22, 2007 at 08=
:47:47PM -0700, Misbah khan wrote:<BR>&gt; yes really it would really gener=
ate a machine check... but i guess if you<BR>&gt; convert this virt address=
 to physical address using __pa() then pass it to<BR>&gt; the ioremap() i g=
uess things will work .<BR><BR>What would be the point? All you'd get is an=
other virtual mapping.<BR><BR>Is the DMA mapping API that difficult?<BR><BR=
>-Scott<BR><BR><BR>------------------------------<BR><BR>Message: 3<BR>Date=
: Mon, 23 Jul 2007 13:34:50 -0700<BR>From: Christoph Lameter <CLAMETER@SGI.=
COM><BR>Subject: Re: [Bugme-new] [Bug 8778] New: Ocotea board: kernel repor=
ts<BR>access of bad area during boot with DEBUG_SLAB=3Dy<BR>To: Andrew Mort=
on <AKPM@LINUX-FOUNDATION.ORG><BR>Cc: netdev@vger.kernel.org, bart.vanassch=
e@gmail.com,<BR>linux-mm@kvack.org, "bugme-daemon@kernel-bugs.osdl.org"<BR>=
<BUGME-DAEMON@BUGZILLA.KERNEL.ORG>, linuxppc-embedded@ozlabs.org<BR>Message=
-ID: &lt;20070723133450.3de91b33@schroedinger.engr.sgi.com&gt;<BR>Content-T=
ype: text/plain; charset=3DUS-ASCII<BR><BR>On Wed, 18 Jul 2007 09:55:37 -07=
00<BR>Andrew Morton <AKPM@LINUX-FOUNDATION.ORG>wrote:<BR><BR>&gt; hm. It sh=
ould be the case that providing SLAB_HWCACHE_ALIGN at<BR>&gt; kmem_cache_cr=
eate() time will override slab-debugging's offsetting<BR>&gt; of the return=
ed addresses.<BR><BR><BR>That is true for SLUB but not in SLAB. SLAB has al=
ways ignored<BR>SLAB_HWCACHE_ALIGN when debugging is on because of the issu=
es involved<BR>in placing the redzone values etc. Could be fun to fix.<BR><=
BR><BR><BR>------------------------------<BR><BR>__________________________=
_____________________<BR>Linuxppc-embedded mailing list<BR>Linuxppc-embedde=
d@ozlabs.org<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR><B=
R>End of Linuxppc-embedded Digest, Vol 35, Issue 51<BR>********************=
*****************************<BR></BLOCKQUOTE><BR>

--=20
<div> Enter the Bourne Ultimatum Sweepstakes<br>
<a href=3D"http://www.hollywoodlife.net/index.php/sweepstakescontests/the-b=
ourne-ultimatum/?utm_source=3Dmail_hl_sent_footer&utm_medium=3Demail&utm_te=
rm=3D070713&utm_content=3Dhl_textlink&utm_campaign=3Dthe-bourne-ultimatum" =
target=3D"_blank">View Trailer, Win Free Prizes.</a> In Theaters 08.03.07</=
div>

--_----------=_118526875242070--
