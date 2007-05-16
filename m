Return-Path: <jcrigby@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 00EAEDDE45
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 01:25:17 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so49637ana
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 08:25:16 -0700 (PDT)
Message-ID: <4b73d43f0705160825s7ab1036eh4f4cf1a151b7e212@mail.gmail.com>
Date: Wed, 16 May 2007 09:25:15 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Sylvain Munaut" <tnt@246tnt.com>,
	"Hans Thielemans" <Hans.Thielemans@metris.com>
Subject: Re: MPC5200 ethernet communication stops unexpected
In-Reply-To: <80AD928CDD8C8C469A1357A9C7B7657FF72E33@kryp01.krypton.be>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17135_14855549.1179329115126"
References: <80AD928CDD8C8C469A1357A9C7B7657FF72E33@kryp01.krypton.be>
Cc: David Kanceruk <david.kanceruk@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_17135_14855549.1179329115126
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sylvain,

This is a shot in the dark but the fact that it is the last word that is
wrong reminds me of your question last week about the Gen_BD_TX
tasks:

>  2) From what I understand, this part process everything execpt the last
> byte :
>
>         0xd9190300, /*   LCDEXT: idx2 = idx2; idx2 > var12; idx2 += inc0
*/
>         0xb8c5e009, /*   LCD: idx3 = *(idx1 + var00000015); ; idx3 += inc1
*/
>         0x03fec398, /*     DRD1A: *idx0 = *idx3; FN=0 init=31 WS=3 RS=3 */
>
>     and this process the remaining (1 to 4) bytes :
>
>         0x9919826a, /*   LCD: idx2 = idx2, idx3 = idx3; idx2 > var9;
> idx2 += inc5, idx3 += inc2 */
>         0x0feac398, /*     DRD1A: *idx0 = *idx3; FN=0 TFD INT init=31
> WS=1 RS=1 */
>
>     But the first group stops when the remaining length <= 4 (continue
> while idx2 > var12, and var12 = 4). So if the buffer has a size multiple
> of 4, that means the last 4 bytes will be processed 1 by 1. But that
> means they may not be written as a full word access right ? I'm writing
> to the AC97 fifo and from doing tests without DMA, not doing full 32
> bits write just doesn't work.

As I said just a shot in the dark.

John

On 5/16/07, Hans Thielemans <Hans.Thielemans@metris.com> wrote:
> Hello Sylvain and David
>
> I think it is a more basic problem then just cache. The setup is using
> the psc2 and
> psc3 in codec32 mode to communicate with a DSP. Because the MPC5200 had
> problems with
> the frame in slave mode (anomaly list), it is used in master mode, and
> sends empty packets
> of 256 bytes to keep the link active, so the DSP can send the data. This
> because the send and
> receive clocks and frames are the same on the mpc5200 side.
>
> The empty packet is a fixed packet in memory, so it is never overwritten
> by the mpc5200 once
> the driver is initialized. So I can not believe in a cache problem. The
> problem is always in the
> last 32 bit word or last 4 bytes in the package. The error rate seems to
> be influenced by cpu activity
> and bus priorities.
>
> I have now changed the protocol to send 260 bytes and just drop the last
> 4 bytes at the receiver.
> This way I had it running this night, transmitting 50 GB without a
> single error.
>
> I would assume it has something to do with the bastcomm engine tasks at
> the end of a dma block.
> And probably something with the bus access. I tried several settings for
> the arbiter and bus configurations
> by changing the registers from within the bdi2000 debugger. Changing
> behavior but no solution.
>
> In the full system there are 6 bestcomm tasks active: fec rx and tx,
> psc2 rx and tx and psc3 rx and tx.
>
> Regards
>
> Hans
>
>
>
> -----Original Message-----
> From: Sylvain Munaut [mailto:tnt@246tNt.com]
> Sent: woensdag 16 mei 2007 8:57
> To: David Kanceruk
> Cc: Hans Thielemans; linuxppc-embedded@ozlabs.org
> Subject: Re: MPC5200 ethernet communication stops unexpected
>
> David Kanceruk wrote:
> > Hello Hans,
> >
> >      Our problem was with the FEC sending data with one or two
> > incorrect bytes when we switched from the MPC5200 to the MPC5200B. The
>
> > byte positions were always the same. The socket buffer has the correct
>
> > data before and after the DMA engine runs but the FEC TxFIFO does not
> > always match.
> >
> > One solution to our problem was to make the following call prior to
> > starting the DMA:
> >
> > flush_dcache_range((unsigned long)skb->data, (unsigned long)skb->data
> > + skb->len);
> >
> > The other solution was to set the BSDIS bit in the XLB config register
>
> > during initialization as follows:
> >
> >   xlb = (struct mpc52xx_xlb *)MPC5xxx_XLB;
> >   out_be32(&xlb->config,  in_be32(&xlb->config) |
> > MPC52xx_XLB_CFG_BSDIS);
> >
> > Either solution works for us. The BSDIS bit is a new feature in the
> > MPC5200B. The MPC5200 did not have this bit.
> >
> > According to the Freescale documentation, (Application note AN3045,
> > for instance) setting this bit is supposed to "disable" BestComm bus
> > snooping. However, I have reason to believe the documentation is in
> > error. Everything I have observed seems to indicate that in the
> > MPC5200 BestComm bus snooping was always enabled or enabled via some
> > other means. In the MPC5200B it appears to be "disabled" at reset (not
>
> > "enabled" as the documentation states). This is why flushing the cache
>
> > manually is one solution. Since setting the BSDIS bit also fixes the
> > problem, it suggests that this actually "enables" BestComm bus
> > snooping instead of disabling it. In my mind, it could all boil down
> > to a simple documentation error.
> >
> That problem is _very_ weird ...
>
> From what I understand, Bestcomm XLB snooping means that when the
> BestComm engine has some data cached internally and that it detects a
> write to the address from where those data comes, he will invalidate his
> cache.
>
> But when the kernel writes data to the skb buffer, they may partially
> stay in cache so there won't be any transaction at all on the xlb bus.
> It's when
> bestcomm will read the skb, that the core will snoop the bus, detects
> there is a read request for some data he has in cache, force a retry of
> the bestcomm read, write the data to memory (via xlb), and finally let
> bestcomm retry the transaction to fetch the good data.
>
> So I guess what "could" happen is that :
>  - The kernel allocate a skb, but it ends up being as the same memory
> location
>     as a "previous" one. (or maybe in a directly following position
> because of
>     prefetch).
>  - You submit it to bestcomm
>  - When bestcomm does the read, since the skb was used "just before",
> the line is still in cache but with the wrong data. Since the kernel
> just wrote the data, there was not yet a xlb transaction because the
> data are still in cpu cache.
> Bestcomm think he has the data (no xlb write so it's cache was not
> invalidated), so he doesn't generate a xlb read. But if there is no xlb
> read the core doesn't get a chance to snoop it and doesn't flush it's
> cache ...
>
> Although that doesn't explain why setting BSDIS high solve the problem,
> nor why there is only 1 byte wrong ...
>
> Have you checked your XLB snoop window setting ? And that core snooping
> is enabled ? Also that you don't use the "nap" power saving feature of
> the core ? (it disables snooping altogether ...).
>
>
>     Sylvain
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_17135_14855549.1179329115126
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sylvain,<br><br>This is a shot in the dark but the fact that it is the last word that is<br>wrong reminds me of your question last week about the Gen_BD_TX<br>tasks:<br><br>&gt;&nbsp;&nbsp;2) From what I understand, this part process everything execpt the last
<br>&gt; byte :<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd9190300, /*&nbsp;&nbsp; LCDEXT: idx2 = idx2; idx2 &gt; var12; idx2 += inc0 */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8c5e009, /*&nbsp;&nbsp; LCD: idx3 = *(idx1 + var00000015); ; idx3 += inc1 */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03fec398, /*&nbsp;&nbsp;&nbsp;&nbsp; DRD1A: *idx0 = *idx3; FN=0 init=31 WS=3 RS=3 */
<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; and this process the remaining (1 to 4) bytes :<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9919826a, /*&nbsp;&nbsp; LCD: idx2 = idx2, idx3 = idx3; idx2 &gt; var9;<br>&gt; idx2 += inc5, idx3 += inc2 */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0feac398, /*&nbsp;&nbsp;&nbsp;&nbsp; DRD1A: *idx0 = *idx3; FN=0 TFD INT init=31
<br>&gt; WS=1 RS=1 */<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; But the first group stops when the remaining length &lt;= 4 (continue<br>&gt; while idx2 &gt; var12, and var12 = 4). So if the buffer has a size multiple<br>&gt; of 4, that means the last 4 bytes will be processed 1 by 1. But that
<br>&gt; means they may not be written as a full word access right ? I&#39;m writing<br>&gt; to the AC97 fifo and from doing tests without DMA, not doing full 32<br>&gt; bits write just doesn&#39;t work.<br><br>As I said just a shot in the dark.
<br><br>John<br><br>On 5/16/07, Hans Thielemans &lt;<a href="mailto:Hans.Thielemans@metris.com">Hans.Thielemans@metris.com</a>&gt; wrote:<br>&gt; Hello Sylvain and David<br>&gt; <br>&gt; I think it is a more basic problem then just cache. The setup is using
<br>&gt; the psc2 and<br>&gt; psc3 in codec32 mode to communicate with a DSP. Because the MPC5200 had<br>&gt; problems with<br>&gt; the frame in slave mode (anomaly list), it is used in master mode, and<br>&gt; sends empty packets
<br>&gt; of 256 bytes to keep the link active, so the DSP can send the data. This<br>&gt; because the send and<br>&gt; receive clocks and frames are the same on the mpc5200 side.<br>&gt; <br>&gt; The empty packet is a fixed packet in memory, so it is never overwritten
<br>&gt; by the mpc5200 once<br>&gt; the driver is initialized. So I can not believe in a cache problem. The<br>&gt; problem is always in the<br>&gt; last 32 bit word or last 4 bytes in the package. The error rate seems to
<br>&gt; be influenced by cpu activity<br>&gt; and bus priorities.<br>&gt; <br>&gt; I have now changed the protocol to send 260 bytes and just drop the last<br>&gt; 4 bytes at the receiver.<br>&gt; This way I had it running this night, transmitting 50 GB without a
<br>&gt; single error.<br>&gt; <br>&gt; I would assume it has something to do with the bastcomm engine tasks at<br>&gt; the end of a dma block.<br>&gt; And probably something with the bus access. I tried several settings for
<br>&gt; the arbiter and bus configurations<br>&gt; by changing the registers from within the bdi2000 debugger. Changing<br>&gt; behavior but no solution.<br>&gt; <br>&gt; In the full system there are 6 bestcomm tasks active: fec rx and tx,
<br>&gt; psc2 rx and tx and psc3 rx and tx.<br>&gt; <br>&gt; Regards<br>&gt; <br>&gt; Hans<br>&gt; <br>&gt; <br>&gt; <br>&gt; -----Original Message-----<br>&gt; From: Sylvain Munaut [mailto:<a href="mailto:tnt@246tNt.com">
tnt@246tNt.com</a>]<br>&gt; Sent: woensdag 16 mei 2007 8:57<br>&gt; To: David Kanceruk<br>&gt; Cc: Hans Thielemans; <a href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a><br>&gt; Subject: Re: MPC5200 ethernet communication stops unexpected
<br>&gt; <br>&gt; David Kanceruk wrote:<br>&gt; &gt; Hello Hans,<br>&gt; &gt;<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Our problem was with the FEC sending data with one or two<br>&gt; &gt; incorrect bytes when we switched from the MPC5200 to the MPC5200B. The
<br>&gt; <br>&gt; &gt; byte positions were always the same. The socket buffer has the correct<br>&gt; <br>&gt; &gt; data before and after the DMA engine runs but the FEC TxFIFO does not<br>&gt; &gt; always match.<br>&gt; &gt;
<br>&gt; &gt; One solution to our problem was to make the following call prior to<br>&gt; &gt; starting the DMA:<br>&gt; &gt;<br>&gt; &gt; flush_dcache_range((unsigned long)skb-&gt;data, (unsigned long)skb-&gt;data<br>&gt; &gt; + skb-&gt;len);
<br>&gt; &gt;<br>&gt; &gt; The other solution was to set the BSDIS bit in the XLB config register<br>&gt; <br>&gt; &gt; during initialization as follows:<br>&gt; &gt;<br>&gt; &gt;&nbsp;&nbsp; xlb = (struct mpc52xx_xlb *)MPC5xxx_XLB;
<br>&gt; &gt;&nbsp;&nbsp; out_be32(&amp;xlb-&gt;config,&nbsp;&nbsp;in_be32(&amp;xlb-&gt;config) |<br>&gt; &gt; MPC52xx_XLB_CFG_BSDIS);<br>&gt; &gt;<br>&gt; &gt; Either solution works for us. The BSDIS bit is a new feature in the<br>&gt; &gt; MPC5200B. The MPC5200 did not have this bit.
<br>&gt; &gt;<br>&gt; &gt; According to the Freescale documentation, (Application note AN3045,<br>&gt; &gt; for instance) setting this bit is supposed to &quot;disable&quot; BestComm bus<br>&gt; &gt; snooping. However, I have reason to believe the documentation is in
<br>&gt; &gt; error. Everything I have observed seems to indicate that in the<br>&gt; &gt; MPC5200 BestComm bus snooping was always enabled or enabled via some<br>&gt; &gt; other means. In the MPC5200B it appears to be &quot;disabled&quot; at reset (not
<br>&gt; <br>&gt; &gt; &quot;enabled&quot; as the documentation states). This is why flushing the cache<br>&gt; <br>&gt; &gt; manually is one solution. Since setting the BSDIS bit also fixes the<br>&gt; &gt; problem, it suggests that this actually &quot;enables&quot; BestComm bus
<br>&gt; &gt; snooping instead of disabling it. In my mind, it could all boil down<br>&gt; &gt; to a simple documentation error.<br>&gt; &gt;<br>&gt; That problem is _very_ weird ...<br>&gt; <br>&gt; From what I understand, Bestcomm XLB snooping means that when the
<br>&gt; BestComm engine has some data cached internally and that it detects a<br>&gt; write to the address from where those data comes, he will invalidate his<br>&gt; cache.<br>&gt; <br>&gt; But when the kernel writes data to the skb buffer, they may partially
<br>&gt; stay in cache so there won&#39;t be any transaction at all on the xlb bus.<br>&gt; It&#39;s when<br>&gt; bestcomm will read the skb, that the core will snoop the bus, detects<br>&gt; there is a read request for some data he has in cache, force a retry of
<br>&gt; the bestcomm read, write the data to memory (via xlb), and finally let<br>&gt; bestcomm retry the transaction to fetch the good data.<br>&gt; <br>&gt; So I guess what &quot;could&quot; happen is that :<br>&gt;&nbsp;&nbsp;- The kernel allocate a skb, but it ends up being as the same memory
<br>&gt; location<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; as a &quot;previous&quot; one. (or maybe in a directly following position<br>&gt; because of<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; prefetch).<br>&gt;&nbsp;&nbsp;- You submit it to bestcomm<br>&gt;&nbsp;&nbsp;- When bestcomm does the read, since the skb was used &quot;just before&quot;,
<br>&gt; the line is still in cache but with the wrong data. Since the kernel<br>&gt; just wrote the data, there was not yet a xlb transaction because the<br>&gt; data are still in cpu cache.<br>&gt; Bestcomm think he has the data (no xlb write so it&#39;s cache was not
<br>&gt; invalidated), so he doesn&#39;t generate a xlb read. But if there is no xlb<br>&gt; read the core doesn&#39;t get a chance to snoop it and doesn&#39;t flush it&#39;s<br>&gt; cache ...<br>&gt; <br>&gt; Although that doesn&#39;t explain why setting BSDIS high solve the problem,
<br>&gt; nor why there is only 1 byte wrong ...<br>&gt; <br>&gt; Have you checked your XLB snoop window setting ? And that core snooping<br>&gt; is enabled ? Also that you don&#39;t use the &quot;nap&quot; power saving feature of
<br>&gt; the core ? (it disables snooping altogether ...).<br>&gt; <br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Sylvain<br>&gt; <br>&gt; ______________________________________________________________________<br>&gt; This email has been scanned by the MessageLabs Email Security System.
<br>&gt; For more information please visit <a href="http://www.messagelabs.com/email">http://www.messagelabs.com/email</a><br>&gt; ______________________________________________________________________<br>&gt; <br>&gt; ______________________________________________________________________
<br>&gt; This email has been scanned by the MessageLabs Email Security System.<br>&gt; For more information please visit <a href="http://www.messagelabs.com/email">http://www.messagelabs.com/email</a><br>&gt; ______________________________________________________________________
<br>&gt; <br>&gt; ______________________________________________________________________<br>&gt; This email has been scanned by the MessageLabs Email Security System.<br>&gt; For more information please visit <a href="http://www.messagelabs.com/email">
http://www.messagelabs.com/email</a><br>&gt; ______________________________________________________________________<br>&gt; <br>&gt; <br>&gt; _______________________________________________<br>&gt; Linuxppc-embedded mailing list
<br>&gt; <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
&gt; <br><br>

------=_Part_17135_14855549.1179329115126--
