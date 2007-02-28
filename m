Return-Path: <jiehanca@yahoo.com.cn>
Received: from web15101.mail.cnb.yahoo.com (web15101.mail.cnb.yahoo.com
	[202.165.103.70]) by ozlabs.org (Postfix) with SMTP id 12FE7DDE00
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 19:01:02 +1100 (EST)
Date: Tue, 27 Feb 2007 23:54:20 -0800 (PST)
From: jie han <jiehanca@yahoo.com.cn>
Subject: help about cann't find smc devcies under kernel 2.6.19
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1513141333-1172649260=:73745"
Message-ID: <945874.73745.qm@web15101.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1513141333-1172649260=:73745
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,
I port my mpc8270 board from kernel-2.4.24 to kernel-2.6.19(based on www.denx.de),I setup smc1 as console port.The kernel .config as follow
#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
# CONFIG_SERIAL_CPM_SCC1 is not set
# CONFIG_SERIAL_CPM_SCC2 is not set
# CONFIG_SERIAL_CPM_SCC3 is not set
# CONFIG_SERIAL_CPM_SCC4 is not set
CONFIG_SERIAL_CPM_SMC1=y
# CONFIG_SERIAL_CPM_SMC2 is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

When I boot it,I cannot get any message dispaly from smc1.I check __log_buf under u-boot environment,the buffer show as follow

001e4844: 363e5365 7269616c 3a204350 4d206472    6>Serial: CPM dr
001e4854: 69766572 20245265 76697369 6f6e3a20    iver $Revision: 
001e4864: 302e3032 20240a3c 363e6370 6d5f7561    0.02 $.<6>cpm_ua
001e4874: 72743a20 5741524e 494e473a 206e6f20    rt: WARNING: no 
001e4884: 55415254 20646576 69636573 20666f75    UART devices fou
001e4894: 6e64206f 6e20706c 6174666f 726d2062    nd on platform b
001e48a4: 7573210a 3c363e63 706d5f75 6172743a    us!.<6>cpm_uart:
001e48b4: 20746865 20647269 76657220 77696c6c     the driver will
001e48c4: 20677565 73732063 6f6e6669 67757261     guess configura
001e48d4: 74696f6e 2c206275 74207468 6973206d    tion, but this m
001e48e4: 6f646520 6973206e 6f206c6f 6e676572    ode is no longer
001e48f4: 20737570 706f7274 65642e0a 3c363e74     supported..<6>t
001e4904: 74794350 4d302061 74204d4d 494f2030    tyCPM0 at MMIO 0
001e4914: 78663030 31316138 30202869 7271203d    xf0011a80 (irq =
001e4924: 20342920 69732061 2043504d 20554152     4) is a CPM UAR
001e4934: 540a3c34 3e52414d 4449534b 20647269    T.<4>RAMDISK dri

It mean system cannot find smc1 under bus when kernel call function cpm_uart_init(),how can i fix this  issue?thanks advance,

By the way,I also create my mpc8270 board support file at /arch/ppc/platform directory,it's like file tqm8260_setup.c.The initialize process as follw,
static int scc8270_platform_notify(struct device *dev)
{
    static const struct platform_notify_dev_map dev_map[] = {
        {
            .bus_id = "fsl-cpm-smc:uart",
            .rtn = scc8270_fixup_uart_pdata,
        },
        {
            .bus_id = "fsl-cpm-fcc",
            .rtn = scc8270_fixup_enet_pdata,
        },
        {
            .bus_id = "fsl-bb-mdio",
            .rtn = scc8270_fixup_mdio_pdata,
        },
        {
            .bus_id = NULL
        }
    };
    platform_notify_map(dev_map,dev);

    return 0;

}

int __init scc8270_init(void)
{
    printk(KERN_NOTICE "scc8270: Init\n");

    platform_notify = scc8270_platform_notify;

    ppc_sys_device_initfunc();

    ppc_sys_device_disable_all();

    ppc_sys_device_enable(MPC82xx_MDIO_BB);

    ppc_sys_device_setfunc(MPC82xx_CPM_SMC1, PPC_SYS_FUNC_UART);
    
    ppc_sys_device_enable(MPC82xx_CPM_SMC1);
    
    ppc_sys_device_enable(MPC82xx_CPM_FCC1);
    
    ppc_sys_device_enable(MPC82xx_CPM_FCC2);
    
    return 0;
}



Sincerely,

Jie


 
---------------------------------
Finding fabulous fares is fun.
Let Yahoo! FareChase search your favorite travel sites to find flight and hotel bargains.
--0-1513141333-1172649260=:73745
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,<br>I port my mpc8270 board from kernel-2.4.24 to kernel-2.6.19(based on www.denx.de),I setup smc1 as console port.The kernel .config as follow<br>#<br># Non-8250 serial port support<br>#<br>CONFIG_SERIAL_CORE=y<br>CONFIG_SERIAL_CORE_CONSOLE=y<br>CONFIG_SERIAL_CPM=y<br>CONFIG_SERIAL_CPM_CONSOLE=y<br># CONFIG_SERIAL_CPM_SCC1 is not set<br># CONFIG_SERIAL_CPM_SCC2 is not set<br># CONFIG_SERIAL_CPM_SCC3 is not set<br># CONFIG_SERIAL_CPM_SCC4 is not set<br>CONFIG_SERIAL_CPM_SMC1=y<br># CONFIG_SERIAL_CPM_SMC2 is not set<br>CONFIG_UNIX98_PTYS=y<br>CONFIG_LEGACY_PTYS=y<br>CONFIG_LEGACY_PTY_COUNT=256<br><br>When I boot it,I cannot get any message dispaly from smc1.I check __log_buf under u-boot environment,the buffer show as follow<br><br>001e4844: 363e5365 7269616c 3a204350 4d206472&nbsp;&nbsp;&nbsp; 6&gt;Serial: CPM dr<br>001e4854: 69766572 20245265 76697369 6f6e3a20&nbsp;&nbsp;&nbsp; iver $Revision: <br>001e4864: 302e3032 20240a3c 363e6370 6d5f7561&nbsp;&nbsp;&nbsp; 0.02
 $.&lt;6&gt;cpm_ua<br>001e4874: 72743a20 5741524e 494e473a 206e6f20&nbsp;&nbsp;&nbsp; rt: WARNING: no <br>001e4884: 55415254 20646576 69636573 20666f75&nbsp;&nbsp;&nbsp; UART devices fou<br>001e4894: 6e64206f 6e20706c 6174666f 726d2062&nbsp;&nbsp;&nbsp; nd on platform b<br>001e48a4: 7573210a 3c363e63 706d5f75 6172743a&nbsp;&nbsp;&nbsp; us!.&lt;6&gt;cpm_uart:<br>001e48b4: 20746865 20647269 76657220 77696c6c&nbsp;&nbsp;&nbsp;&nbsp; the driver will<br>001e48c4: 20677565 73732063 6f6e6669 67757261&nbsp;&nbsp;&nbsp;&nbsp; guess configura<br>001e48d4: 74696f6e 2c206275 74207468 6973206d&nbsp;&nbsp;&nbsp; tion, but this m<br>001e48e4: 6f646520 6973206e 6f206c6f 6e676572&nbsp;&nbsp;&nbsp; ode is no longer<br>001e48f4: 20737570 706f7274 65642e0a 3c363e74&nbsp;&nbsp;&nbsp;&nbsp; supported..&lt;6&gt;t<br>001e4904: 74794350 4d302061 74204d4d 494f2030&nbsp;&nbsp;&nbsp; tyCPM0 at MMIO 0<br>001e4914: 78663030 31316138 30202869 7271203d&nbsp;&nbsp;&nbsp; xf0011a80 (irq =<br>001e4924:
 20342920 69732061 2043504d 20554152&nbsp;&nbsp;&nbsp;&nbsp; 4) is a CPM UAR<br>001e4934: 540a3c34 3e52414d 4449534b 20647269&nbsp;&nbsp;&nbsp; T.&lt;4&gt;RAMDISK dri<br><br>It mean system cannot find smc1 under bus when kernel call function cpm_uart_init(),how can i fix this&nbsp; issue?thanks advance,<br><br>By the way,I also create my mpc8270 board support file at /arch/ppc/platform directory,it's like file tqm8260_setup.c.The initialize process as follw,<br>static int scc8270_platform_notify(struct device *dev)<br>{<br>&nbsp;&nbsp;&nbsp; static const struct platform_notify_dev_map dev_map[] = {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .bus_id = "fsl-cpm-smc:uart",<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rtn = scc8270_fixup_uart_pdata,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .bus_id =
 "fsl-cpm-fcc",<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rtn = scc8270_fixup_enet_pdata,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .bus_id = "fsl-bb-mdio",<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rtn = scc8270_fixup_mdio_pdata,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .bus_id = NULL<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; platform_notify_map(dev_map,dev);<br><br>&nbsp;&nbsp;&nbsp; return 0;<br><br>}<br><br>int __init scc8270_init(void)<br>{<br>&nbsp;&nbsp;&nbsp; printk(KERN_NOTICE "scc8270: Init\n");<br><br>&nbsp;&nbsp;&nbsp; platform_notify = scc8270_platform_notify;<br><br>&nbsp;&nbsp;&nbsp; ppc_sys_device_initfunc();<br><br>&nbsp;&nbsp;&nbsp;
 ppc_sys_device_disable_all();<br><br>&nbsp;&nbsp;&nbsp; ppc_sys_device_enable(MPC82xx_MDIO_BB);<br><br>&nbsp;&nbsp;&nbsp; ppc_sys_device_setfunc(MPC82xx_CPM_SMC1, PPC_SYS_FUNC_UART);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; ppc_sys_device_enable(MPC82xx_CPM_SMC1);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; ppc_sys_device_enable(MPC82xx_CPM_FCC1);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; ppc_sys_device_enable(MPC82xx_CPM_FCC2);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br><br>Sincerely,<br><br>Jie<br><br><p>&#32;

<hr size=1>Finding fabulous fares is fun.<br><a href="http://farechase.yahoo.com/promo-generic-14795097;_ylc=X3oDMTFtNW45amVpBF9TAzk3NDA3NTg5BF9zAzI3MTk0ODEEcG9zAzEEc2VjA21haWx0YWdsaW5lBHNsawNxMS0wNw--
">Let Yahoo! FareChase search your favorite travel sites</a> to find flight and hotel bargains.
--0-1513141333-1172649260=:73745--
