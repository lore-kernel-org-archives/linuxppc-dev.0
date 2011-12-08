Return-Path: <prashantsmailcenter@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DB16F1007D1
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 00:02:11 +1100 (EST)
Received: by eekc13 with SMTP id c13so1218571eek.15
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Dec 2011 05:01:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1323295383.12793.3.camel@pasglop>
References: <CAD6p20dmksH7YEjijdqLRG06aigaKTpzLPdoL0SCNGD3Ji9d2A@mail.gmail.com>
 <1322198727.32635.25.camel@pasglop>
 <CAD6p20chCnh+PN5ekPz20BJQMdTaisb5toLA9rySaYJTeivRfQ@mail.gmail.com>
 <1323295383.12793.3.camel@pasglop>
Date: Thu, 8 Dec 2011 18:31:59 +0530
Message-ID: <CAD6p20eC22MUMjbnDW55mfkojrBTWLwvMDjpM-DPZYcgxKTbZg@mail.gmail.com>
Subject: Re: ibm_newemac tx problem with jumbo frame enabled
From: Prashant Bhole <prashantsmailcenter@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=00504502c860173a3f04b3944635
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502c860173a3f04b3944635
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Dec 8, 2011 at 3:33 AM, Benjamin Herrenschmidt <
benh@kernel.crashing.org> wrote:

> On Wed, 2011-12-07 at 13:35 +0530, Prashant Bhole wrote:
> > Still couldn't find anything like fifo overflow...
> > I noticed one more thing, this problem happens only when mtu size on
> > the initiator (the other end) is set to 4088, regardless of any mtu
> > size set for EMAC.
>
> Did you check all the registers that may carry errors ? Nothing showed
> up ? Did you check that things like Pause frames were properly
> negociated on both sides ? Tried playing with the pause and FIFO
> thresholds ?
>
> Other than using the tx timeout to perform resets I don't see a good way
> to fix that problem.
>
> Cheers,
> Ben.
>
>
I checked RX descriptor status and TX descriptor status and ethtool output.
However I don't know about pause packet/frame, how do I check if pause
frames are properly negotiated on both sides?
I need to try changing pause and FIFO thresholds.

ethtool output after disconnection is as follows:
# ethtool -S eth0
NIC statistics:
     rx_packets: 330939
     rx_bytes: 804963241
     tx_packets: 248554
     tx_bytes: 798853638
     rx_packets_csum: 330716
     tx_packets_csum: 179526
     tx_undo: 0
     rx_dropped_stack: 0
     rx_dropped_oom: 0
     rx_dropped_error: 0
     rx_dropped_resize: 0
     rx_dropped_mtu: 0
     rx_stopped: 0
     rx_bd_errors: 0
     rx_bd_overrun: 0
     rx_bd_bad_packet: 0
     rx_bd_runt_packet: 0
     rx_bd_short_event: 0
     rx_bd_alignment_error: 0
     rx_bd_bad_fcs: 0
     rx_bd_packet_too_long: 0
     rx_bd_out_of_range: 0
     rx_bd_in_range: 0
     rx_parity: 0
     rx_fifo_overrun: 0
     rx_overrun: 0
     rx_bad_packet: 0
     rx_runt_packet: 0
     rx_short_event: 0
     rx_alignment_error: 0
     rx_bad_fcs: 0
     rx_packet_too_long: 0
     rx_out_of_range: 0
     rx_in_range: 0
     tx_dropped: 0
     tx_bd_errors: 0
     tx_bd_bad_fcs: 0
     tx_bd_carrier_loss: 0
     tx_bd_excessive_deferral: 0
     tx_bd_excessive_collisions: 0
     tx_bd_late_collision: 0
     tx_bd_multple_collisions: 0
     tx_bd_single_collision: 0
     tx_bd_underrun: 0
     tx_bd_sqe: 0
     tx_parity: 0
     tx_underrun: 0
     tx_sqe: 0
     tx_errors: 0


Thanks,
Prashant

--00504502c860173a3f04b3944635
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Dec 8, 2011 at 3:33 AM, Benjamin=
 Herrenschmidt <span dir=3D"ltr">&lt;<a href=3D"mailto:benh@kernel.crashing=
.org" target=3D"_blank">benh@kernel.crashing.org</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">

<div>On Wed, 2011-12-07 at 13:35 +0530, Prashant Bhole wrote:<br>
&gt; Still couldn&#39;t find anything like fifo overflow...<br>
&gt; I noticed one more thing, this problem happens only when mtu size on<b=
r>
&gt; the initiator (the other end) is set to 4088, regardless of any mtu<br=
>
&gt; size set for EMAC.<br>
<br>
</div>Did you check all the registers that may carry errors ? Nothing showe=
d<br>
up ? Did you check that things like Pause frames were properly<br>
negociated on both sides ? Tried playing with the pause and FIFO<br>
thresholds ?<br>
<br>
Other than using the tx timeout to perform resets I don&#39;t see a good wa=
y<br>
to fix that problem.<br>
<br>
Cheers,<br>
Ben.<br>
<br></blockquote><div>=A0<br>I checked RX descriptor status and TX descript=
or status and ethtool output.<br>However I don&#39;t know about pause packe=
t/frame, how do I check if pause<br>frames are properly negotiated on both =
sides? <br>

I need to try changing pause and FIFO thresholds.<br><br>ethtool output aft=
er disconnection is as follows:<br># ethtool -S eth0<br>NIC statistics:<br>=
=A0=A0=A0=A0 rx_packets: 330939<br>=A0=A0=A0=A0 rx_bytes: 804963241<br>=A0=
=A0=A0=A0 tx_packets: 248554<br>

=A0=A0=A0=A0 tx_bytes: 798853638<br>=A0=A0=A0=A0 rx_packets_csum: 330716<br=
>=A0=A0=A0=A0 tx_packets_csum: 179526<br>=A0=A0=A0=A0 tx_undo: 0<br>=A0=A0=
=A0=A0 rx_dropped_stack: 0<br>=A0=A0=A0=A0 rx_dropped_oom: 0<br>=A0=A0=A0=
=A0 rx_dropped_error: 0<br>=A0=A0=A0=A0 rx_dropped_resize: 0<br>

=A0=A0=A0=A0 rx_dropped_mtu: 0<br>=A0=A0=A0=A0 rx_stopped: 0<br>=A0=A0=A0=
=A0 rx_bd_errors: 0<br>=A0=A0=A0=A0 rx_bd_overrun: 0<br>=A0=A0=A0=A0 rx_bd_=
bad_packet: 0<br>=A0=A0=A0=A0 rx_bd_runt_packet: 0<br>=A0=A0=A0=A0 rx_bd_sh=
ort_event: 0<br>=A0=A0=A0=A0 rx_bd_alignment_error: 0<br>=A0=A0=A0=A0 rx_bd=
_bad_fcs: 0<br>

=A0=A0=A0=A0 rx_bd_packet_too_long: 0<br>=A0=A0=A0=A0 rx_bd_out_of_range: 0=
<br>=A0=A0=A0=A0 rx_bd_in_range: 0<br>=A0=A0=A0=A0 rx_parity: 0<br>=A0=A0=
=A0=A0 rx_fifo_overrun: 0<br>=A0=A0=A0=A0 rx_overrun: 0<br>=A0=A0=A0=A0 rx_=
bad_packet: 0<br>=A0=A0=A0=A0 rx_runt_packet: 0<br>=A0=A0=A0=A0 rx_short_ev=
ent: 0<br>

=A0=A0=A0=A0 rx_alignment_error: 0<br>=A0=A0=A0=A0 rx_bad_fcs: 0<br>=A0=A0=
=A0=A0 rx_packet_too_long: 0<br>=A0=A0=A0=A0 rx_out_of_range: 0<br>=A0=A0=
=A0=A0 rx_in_range: 0<br>=A0=A0=A0=A0 tx_dropped: 0<br>=A0=A0=A0=A0 tx_bd_e=
rrors: 0<br>=A0=A0=A0=A0 tx_bd_bad_fcs: 0<br>=A0=A0=A0=A0 tx_bd_carrier_los=
s: 0<br>

=A0=A0=A0=A0 tx_bd_excessive_deferral: 0<br>=A0=A0=A0=A0 tx_bd_excessive_co=
llisions: 0<br>=A0=A0=A0=A0 tx_bd_late_collision: 0<br>=A0=A0=A0=A0 tx_bd_m=
ultple_collisions: 0<br>=A0=A0=A0=A0 tx_bd_single_collision: 0<br>=A0=A0=A0=
=A0 tx_bd_underrun: 0<br>=A0=A0=A0=A0 tx_bd_sqe: 0<br>

=A0=A0=A0=A0 tx_parity: 0<br>=A0=A0=A0=A0 tx_underrun: 0<br>=A0=A0=A0=A0 tx=
_sqe: 0<br>=A0=A0=A0=A0 tx_errors: 0<br></div></div><br><br>Thanks,<br>Pras=
hant<br>

--00504502c860173a3f04b3944635--
