Message-ID: <39CB2CBB.E3878701@mpifr-bonn.mpg.de>
Date: Fri, 22 Sep 2000 11:56:11 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: "Garst R. Reese" <reese@isn.net>
CC: linux-irda@pasta.cs.UiT.No,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Linux-IrDA]IrDA speed w/LinuxPPC: again [long, sorry]
References: <39C9F8A2.9F1707B0@mpifr-bonn.mpg.de> <39CA1221.340B4C52@isn.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Garst R. Reese" wrote:
> Part of what you are seeing is the working of the IrDA spec. Everything
> starts at 9600baud to negotiate a connection. Part of this negotiation
> is the speed it will switch to when a connection is established. This

Does this mean that I do not have any chance to change the speed after the
device is found? I tried a "stty -F /dev/irlpt0 115200" after the printer was
discovered, but there is no hint at all in the debug logs that this command got
through.

The following extract from the debug messages seems to be the establishing of
the connection to the printer, right? Why does it set the baud rate to zero? Is
it possible to get more details of the negotiation process to see if there is
something weird going on?

kernel: irlap_initiate_connection_state()
kernel: irda_param_extract(), pi=[0,1], type=0
kernel: Requested BAUD_RATE: 0x0000
kernel: Final BAUD_RATE: 0x0000
kernel: irda_param_extract(), pi=[1,2], type=1
kernel: irda_param_extract(), pi=[1,3], type=1
kernel: irda_param_extract(), pi=[1,4], type=1
kernel: irda_param_extract(), pi=[1,5], type=1
kernel: irda_param_extract(), pi=[1,6], type=1
kernel: irda_param_extract(), pi=[0,8], type=1
kernel: LINK_DISC: 07
kernel: Final LINK_DISC: 07
kernel: irlap_qos_negotiate(), Compression not seen!
kernel: irlap_adjust_qos_settings()
kernel: irlap_max_line_capacity(), speed=0, max_turn_time=500
kernel: irlap_max_line_capacity(), line capacity=200000 bytes
kernel: Setting BAUD_RATE to 0 bps.
kernel: Setting DATA_SIZE to 256 bytes
kernel: Setting WINDOW_SIZE to 1
kernel: Setting XBOFS to 0
kernel: Setting MAX_TURN_TIME to 500 ms.
kernel: Setting MIN_TURN_TIME to 10000 usecs.
kernel: Setting LINK_DISC to 12 secs.
kernel: Setting COMPRESSION to 0
kernel: irlap_apply_connection_parameters()
kernel: irlap_change_speed(), setting speed to 0
kernel: irlap_max_line_capacity(), speed=0, max_turn_time=500
kernel: irlap_max_line_capacity(), line capacity=200000 bytes
kernel: Setting N1 = 6
kernel: Setting N2 = 24
kernel: async_wrap_skb(), xbofs=0
kernel: rs_interrupt: irq 16, zs_intreg 0x2
kernel: rs_interrupt: irq 16, zs_intreg 0x0
kernel: next LAP state = LAP_NRM_P
kernel: irlap_connect_confirm()

Thanks, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
