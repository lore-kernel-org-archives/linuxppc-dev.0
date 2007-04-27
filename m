Return-Path: <david.kanceruk@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id B37C4DDFAE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 04:15:59 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so845566ana
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 11:15:58 -0700 (PDT)
Message-ID: <5b525e390704271115v4aac6a81xbcb54c7ac011088@mail.gmail.com>
Date: Fri, 27 Apr 2007 13:15:57 -0500
From: "David Kanceruk" <david.kanceruk@gmail.com>
To: "Eberhard Stoll" <eberhard.stoll@berghof.com>
Subject: Re: MPC5200 ethernet communication stops unexpected
In-Reply-To: <4632369E.8010000@berghof.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_369159_14240688.1177697757920"
References: <462912AC.8090102@berghof.com> <10220160.post@talk.nabble.com>
	<46322E3F.8050508@berghof.com>
	<5b525e390704271022x599e5504g4f31df9c01965010@mail.gmail.com>
	<4632369E.8010000@berghof.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_369159_14240688.1177697757920
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Eberhard,

    I have the problem with corrupted data on the MPC5200B. I traced the
problem to the BestComm driver. I see the correct data in the socket buffer
for the icmp reply but when BestComm puts the data into the Tx FIFO of the
fec, it sometimes puts the wrong byte in location 0 (which corrupts the
ethernet destination address) or location 62 (which corrupts the ping data).
These locations are always the same locations. Here is the contents of some
sample buffers I captured after gracefully stopping the fec transmitter (so
I could examine the FIFO without the fec doing a reset):

icmp csum = 7c2b
skb->data = 14
skb->dst->output = c0175924
neigh_hh_output calls = c0162b20
calling neigh->ops->queue_xmit c015c360
calling q->enqueue c0168034
dev->hard_start_xmit = c013ff3c
before - fec_hard_start_xmit 1 skb->data = 14      ----------------- this is
at offset 62
after - fec_hard_start_xmit 1 skb->data = 14         ----------------- still
has the correct value
start_addr = 00000160, end_addr = 000001C6, buf_len = 00000066
FEC IEVENT- 00000000
00003923 CD3F0050 C2263023 08004500  ----------------- this is what is in
the fec Tx FIFO
005437E3 00004001 BF72C0A8 0102C0A8
01010000 7C2B064A 000405C4 27466579
00000809 0A0B0C0D 0E0F1011 12130015   ---------------- second last byte is
00 --- this is bad!
16171819 1A1B1C1D 1E1F2021 22232425
26272829 2A2B2C2D 2E2F3031 32333435
FEC IEVENT- 00000000
icmp csum = 3a2a
skb->data = 14
skb->dst->output = c0175924
neigh_hh_output calls = c0162b20
calling neigh->ops->queue_xmit c015c360
calling q->enqueue c0168034
dev->hard_start_xmit = c013ff3c
before - fec_hard_start_xmit 1 skb->data = 14
after - fec_hard_start_xmit 1 skb->data = 14
start_addr = 000001C6, end_addr = 0000022C, buf_len = 00000066
FEC IEVENT- 00000000
00003923 CD3F0050 C2263023 08004500
005437E4 00004001 BF71C0A8 0102C0A8
01010000 3A2A064A 000506C4 2746A679
00000809 0A0B0C0D 0E0F1011 12131415   ---------------- second last byte is
14 --- this is good this time!
16171819 1A1B1C1D 1E1F2021 22232425
26272829 2A2B2C2D 2E2F3031 32333435
FEC IEVENT- 00000000

I think we need to focus on how the BestComm driver works now. I wonder if
there are any experts out there that might know what could be wrong?

Best regards,

Dave

On 4/27/07, Eberhard Stoll <eberhard.stoll@berghof.com> wrote:
>
> Hi,
> >      Do your boards use the MPC5200B or MPC5200? Also, do you ever see
> > any corrupted data? (I'm guessing you would have mentioned it if you
> > did see corrupted data)
> I use MPC5200B processors. With MPC5200(A) processors i don't get this
> error!
> I didn't recognize corrupted data 'til now. But this could be - now i'm
> sending only pings and sometimes get output like this on the console:
> -- 8< --
>
> ..............................................................................tcp_recheck_csum:
> seq 0x5881325f retransmit, csum 0x232b OK?
> .............................................tcp_recheck_csum: seq
> 0x58813dd6 retransmit, csum 0xd1ad OK?
> ...............tcp_recheck_csum: seq 0x58814286 retransmit, csum 0xee5b
> OK?
> .....................tcp_recheck_csum: seq 0x58814982 retransmit, csum
> 0x8528 OK?
> ..............................................tcp_recheck_csum: seq
> 0x58815601 retransmit, csum 0x6ee1 OK?
> -- 8< --
> but i don't know what it means and where it comes from. Does someone know?
>
> Eberhard
>
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>



-- 
David Kanceruk

"The generation of random numbers is far too important to be left to
chance."

------=_Part_369159_14240688.1177697757920
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Eberhard,<br><br>&nbsp;&nbsp;&nbsp; I have the problem with corrupted data on the MPC5200B. I traced the problem to the BestComm driver. I see the correct data in the socket buffer for the icmp reply but when BestComm puts the data into the Tx FIFO of the fec, it sometimes puts the wrong byte in location 0 (which corrupts the ethernet destination address) or location 62 (which corrupts the ping data). These locations are always the same locations. Here is the contents of some sample buffers I captured after gracefully stopping the fec transmitter (so I could examine the FIFO without the fec doing a reset):
<br><br>icmp csum = 7c2b<br>skb-&gt;data = 14<br>skb-&gt;dst-&gt;output = c0175924<br>neigh_hh_output calls = c0162b20<br>calling neigh-&gt;ops-&gt;queue_xmit c015c360<br>calling q-&gt;enqueue c0168034<br>dev-&gt;hard_start_xmit = c013ff3c
<br>before - fec_hard_start_xmit 1 skb-&gt;data = 14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------- this is at offset 62<br>after - fec_hard_start_xmit 1 skb-&gt;data = 14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------- still has the correct value<br>start_addr = 00000160, end_addr = 000001C6, buf_len = 00000066
<br>FEC IEVENT- 00000000<br>00003923 CD3F0050 C2263023 08004500&nbsp; ----------------- this is what is in the fec Tx FIFO<br>005437E3 00004001 BF72C0A8 0102C0A8<br>01010000 7C2B064A 000405C4 27466579<br>00000809 0A0B0C0D 0E0F1011 12130015&nbsp;&nbsp; ---------------- second last byte is 00 --- this is bad!
<br>16171819 1A1B1C1D 1E1F2021 22232425<br>26272829 2A2B2C2D 2E2F3031 32333435<br>FEC IEVENT- 00000000<br>icmp csum = 3a2a<br>skb-&gt;data = 14<br>skb-&gt;dst-&gt;output = c0175924<br>neigh_hh_output calls = c0162b20<br>calling neigh-&gt;ops-&gt;queue_xmit c015c360
<br>calling q-&gt;enqueue c0168034<br>dev-&gt;hard_start_xmit = c013ff3c<br>before - fec_hard_start_xmit 1 skb-&gt;data = 14<br>after - fec_hard_start_xmit 1 skb-&gt;data = 14<br>start_addr = 000001C6, end_addr = 0000022C, buf_len = 00000066
<br>FEC IEVENT- 00000000<br>00003923 CD3F0050 C2263023 08004500<br>005437E4 00004001 BF71C0A8 0102C0A8<br>01010000 3A2A064A 000506C4 2746A679<br>00000809 0A0B0C0D 0E0F1011 12131415&nbsp;&nbsp; ---------------- second last byte is 14 --- this is good this time!
<br>16171819 1A1B1C1D 1E1F2021 22232425<br>26272829 2A2B2C2D 2E2F3031 32333435<br>FEC IEVENT- 00000000<br><br>I think we need to focus on how the BestComm driver works now. I wonder if there are any experts out there that might know what could be wrong?
<br><br>Best regards,<br><br>Dave<br><br><div><span class="gmail_quote">On 4/27/07, <b class="gmail_sendername">Eberhard Stoll</b> &lt;<a href="mailto:eberhard.stoll@berghof.com">eberhard.stoll@berghof.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Do your boards use the MPC5200B or MPC5200? Also, do you ever see<br>&gt; any corrupted data? (I&#39;m guessing you would have mentioned it if you
<br>&gt; did see corrupted data)<br>I use MPC5200B processors. With MPC5200(A) processors i don&#39;t get this<br>error!<br>I didn&#39;t recognize corrupted data &#39;til now. But this could be - now i&#39;m<br>sending only pings and sometimes get output like this on the console:
<br>-- 8&lt; --<br>..............................................................................tcp_recheck_csum:<br>seq 0x5881325f retransmit, csum 0x232b OK?<br>.............................................tcp_recheck_csum: seq
<br>0x58813dd6 retransmit, csum 0xd1ad OK?<br>...............tcp_recheck_csum: seq 0x58814286 retransmit, csum 0xee5b OK?<br>.....................tcp_recheck_csum: seq 0x58814982 retransmit, csum<br>0x8528 OK?<br>..............................................tcp_recheck_csum: seq
<br>0x58815601 retransmit, csum 0x6ee1 OK?<br>-- 8&lt; --<br>but i don&#39;t know what it means and where it comes from. Does someone know?<br><br>Eberhard<br><br><br>______________________________________________________________________
<br>This email has been scanned by the MessageLabs Email Security System.<br>For more information please visit <a href="http://www.messagelabs.com/email">http://www.messagelabs.com/email</a><br>______________________________________________________________________
<br></blockquote></div><br><br clear="all"><br>-- <br>David Kanceruk<br><br>&quot;The generation of random numbers is far too important to be left to chance.&quot;

------=_Part_369159_14240688.1177697757920--
