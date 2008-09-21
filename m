Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <48D6C8F0.4060808@ru.mvista.com>
Date: Mon, 22 Sep 2008 02:21:36 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: solution to printk() blocking interrupts?
References: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>
	<9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>
In-Reply-To: <9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Jon Smirl wrote:
> On Sun, Sep 21, 2008 at 4:53 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>   
>> Does anyone have a solution to the problem of printk() to a serial
>> console blocking interrupts for too long? I'm losing interrupts I need
>> because my hardware is getting overrun.
>>     
>
> netconsole is not an option on mpc5200....
>
> Kernel command line: console=ttyPSC0,115200 rw debug root=/dev/nfs
> ip=dhcp nfsroot=192.168.1.4:/home/OSELAS.BSP-Phytec-phyCORE-MPC5200B-tiny-6/root,v3,tcp
> netconsole=6666@192.168.1.11/eth0,514@192.168.1.4/00:19:d1:e4:0f:8d
> netconsole: local port 6666
> netconsole: local IP 192.168.1.11
> netconsole: interface eth0
> netconsole: remote port 514
> netconsole: remote IP 192.168.1.4
> netconsole: remote ethernet address 00:19:d1:e4:0f:8d
> netconsole: eth0 doesn't support polling, aborting.
> netconsole: cleaning up
>   

   Implementing the poll_controller() method in the network driver is 
usually staightforward.

WBR, Sergei
