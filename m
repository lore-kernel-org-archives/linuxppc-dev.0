Message-ID: <4014DD1D.8070704@devcom.cz>
Date: Mon, 26 Jan 2004 10:25:49 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC823E SMC/I2C/SPI micropatch
References: <20040126080100.26782C108D@atlas.denx.de>
In-Reply-To: <20040126080100.26782C108D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think I have selected the __correct__ one.
Situated in ./arch/ppc/8xx_io/micropatch_850.c file.
- relocates I2C, SPI, SMC parameter RAM.
- it is determined for 850 and 823E processors (I hope).
- I had to define USE_SMC_PATCH and write some
   additional code for relocating SMC parameter RWM
   in cpm_load_patch() function (./arch/ppc/8xx_io/micropatch.c)
   as well as in SMC UART code (./arch/ppc/8xx_io/uart.c).
More additional hacks needed:
* original RPBASE set to 0x400 clashed with SMC micropatch
   so I redefined it to 0x800
* when used ethernets on SCC2,SCC3 with CONFIG_ENET_BIG_BUFFERS
   enabled, they need 2kB of DPRAM - it cannot fit together with
   micropatch in first 4kB of DPRAM, so I redefined
   CPM_DATAONLY_BASE to 0x1000 and CPM_DATAONLY_SIZE to 0x0c00

And for now, I have SCC2,SCC3 ethernets
and SMC1,SMC2 UARTs working altogether.

                               Sincerely, Jan Damborsky

Wolfgang Denk wrote:
> In message <4014C088.1020208@devcom.cz> you wrote:
>
>>I have found out that CPM micropatch
>>available in linux-2.4 from Wolfgang Denk
>>site (the kernel we use successfuly on our
>>custom boards at present) is applicable as well.
>
>
> You have to select the _correct_ uCode patch.
>
> There is one patch for the MPC850, and another one for all other  8xx
> processors. And there is the USB SOF potch for the MPC823.
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Another dream that failed.  There's nothing sadder.
> 	-- Kirk, "This side of Paradise", stardate 3417.3
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
