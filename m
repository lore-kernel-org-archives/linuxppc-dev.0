Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 187D92BF07
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jan 2005 21:29:21 +1100 (EST)
Received: from edge1.siol.net ([10.10.10.210]) by mta1.siol.net with ESMTP
	id <20050105102912.VTTK3380.mta1.siol.net@edge1.siol.net>
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Jan 2005 11:29:12 +0100
Received: from linux.asist ([193.95.241.43]) by edge1.siol.net with ESMTP
	id <20050105102911.DZAA29321.edge1.siol.net@linux.asist>
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Jan 2005 11:29:11 +0100
Received: from [192.168.254.58] (unknown [192.168.254.58])
	by linux.asist (Postfix) with ESMTP id 524E9644A9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jan 2005 11:29:07 +0100 (CET)
Message-ID: <41DBC173.20901@asist-traffic.com>
Date: Wed, 05 Jan 2005 11:29:07 +0100
From: ivica@asist-traffic.com
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
References: <41C72733.9030300@asist-traffic.com> <41CD5E60.10404@246tNt.com>
In-Reply-To: <41CD5E60.10404@246tNt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: i2c on mpc5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:

>
> Are you sure it doesn't work ?
> On my system there are no I2C init message either, the driver is just 
> not noisy ... (unless you activate all the I2C debug stuff).


Debug stuff didn't output any messages. Then I simply listed kernel 
symbol table and grep for i2c. This is what I got.:
# cat proc/kallsyms |grep i2c

c00e4134 T i2c_device_probe
c00e413c T i2c_device_remove
c00e4144 t i2c_adapter_dev_release
c00e4168 t i2c_adapter_class_dev_release
c00e41bc t i2c_client_release
c00e4210 T i2c_add_adapter
c00e447c T i2c_del_adapter
c00e4758 T i2c_add_driver
c00e48a4 T i2c_del_driver
c00e4adc t __i2c_check_addr
c00e4b20 T i2c_check_addr
c00e4be8 T i2c_adapter_id
c00e4bf0 T i2c_attach_client
c00e4dec T i2c_detach_client
c00e4f48 t i2c_dec_use_client
c00e4f4c T i2c_use_client
c00e4f98 T i2c_release_client
c00e4ff8 T i2c_clients_command
c00e512c t i2c_device_match
c00e5134 t i2c_bus_suspend
c00e5194 t i2c_bus_resume
c00e51f4 T i2c_transfer
c00e5304 T i2c_master_send
c00e5438 T i2c_master_recv
c00e55b4 T i2c_control
c00e56a4 T i2c_get_adapter
c00e57a8 T i2c_put_adapter
c00e57dc T i2c_smbus_partial_pec
c00e5870 T i2c_smbus_pec
c00e58a4 T i2c_smbus_add_pec
c00e5994 T i2c_smbus_check_pec
c00e5ad0 T i2c_get_functionality
c00e5b10 T i2c_check_functionality
c00e5b4c T i2c_smbus_xfer
c00e6130 T i2c_smbus_read_i2c_block_data
c00e61b8 T i2c_smbus_block_process_call
c00e627c T i2c_smbus_write_block_data
c00e6304 T i2c_smbus_write_word_data
c00e6348 T i2c_smbus_read_word_data
c00e6398 T i2c_smbus_write_byte_data
c00e63dc T i2c_smbus_read_byte_data
c00e642c T i2c_smbus_write_byte
c00e646c T i2c_smbus_read_byte
c00e64bc T i2c_smbus_write_quick
c00e64e0 T i2c_probe
c00e6a2c T i2c_dev_get_by_minor
c00e6a40 T i2c_dev_get_by_adapter
c00e6a80 t return_i2c_dev
c00e6b0c t i2cdev_read
c00e6c20 t i2cdev_write
c00e6d30 T i2cdev_ioctl
c00e74e0 t i2cdev_open
c00e7580 t i2cdev_release
c00e75c8 t release_i2c_dev
c00e75ec t i2cdev_attach_adapter
c00e77b4 t i2cdev_detach_adapter
c00e7868 t i2cdev_detach_client
c00e7870 t i2cdev_commandc00e7878 T i2c_detect
c00e7d74 T i2c_which_vrm
c00e7da0 t mpc_i2c_isr
c00e7e20 t i2c_wait
c00e953c t i2c_start
c00e95e0 t i2c_repstart
c00e9790 t i2c_stop
c00e9904 t i2c_outb
c00ea71c T i2c_bit_add_bus
c00eace4 T i2c_bit_del_bus
c00ead04 t i2c_start
c00ead8c t i2c_repstart
c00eae14 t i2c_stop
c00eb608 T i2c_pcf_add_bus
c00eb8e8 T i2c_pcf_del_bus
c00ec1c4 T i2c_pca_add_bus
c00ec2e4 T i2c_pca_del_bus
c01569a0 t i2c_exit
c01569e0 t i2c_dev_exit
c0156a34 t mpc_i2c_remove
c01b7e20 t i2c_init
c01b7e7c t i2c_dev_init
c01b7f40 t mpc_i2c_probe


I think this proves i2c support is in the kernel. Right?

regards,
Ivica
