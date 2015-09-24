Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E02E51A1915
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:47:47 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 24 Sep 2015 15:47:45 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 17918C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 15:38:45 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8OJlfqK57540634
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 19:47:41 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8OJlePn023889
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 15:47:41 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v3 11/32] cxlflash: Refine host/device attributes
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443123542-17003-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Thu, 24 Sep 2015 14:47:41 -0500
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <1B4279AE-3E6A-4409-8F2A-36BF7FA85B27@linux.vnet.ibm.com>
References: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443123542-17003-1-git-send-email-mrochs@linux.vnet.ibm.com>
To: linux-scsi <linux-scsi@vger.kernel.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Shane Seymour <shane.seymour@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Somehow the Suggested-by tag was dropped from this one. Adding it back.

-matt

> On Sep 24, 2015, at 2:39 PM, Matthew R. Ochs =
<mrochs@linux.vnet.ibm.com> wrote:
>=20
> Implement the following suggestions and add two new attributes
> to allow for debugging the port LUN table.
>=20
> - use scnprintf() instead of snprintf()
> - use DEVICE_ATTR_RO and DEVICE_ATTR_RW
>=20
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
Suggested-by: Shane Seymour <shane.seymour@hp.com>

> ---
> drivers/scsi/cxlflash/main.c | 180 =
+++++++++++++++++++++++++++++++++----------
> 1 file changed, 138 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/scsi/cxlflash/main.c =
b/drivers/scsi/cxlflash/main.c
> index 226cefe..b44212b 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -1995,33 +1995,24 @@ static int cxlflash_change_queue_depth(struct =
scsi_device *sdev, int qdepth)
>=20
> /**
>  * cxlflash_show_port_status() - queries and presents the current port =
status
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> + * @port:	Desired port for status reporting.
> + * @afu:	AFU owning the specified port.
>  * @buf:	Buffer of length PAGE_SIZE to report back port status in =
ASCII.
>  *
>  * Return: The size of the ASCII string returned in @buf.
>  */
> -static ssize_t cxlflash_show_port_status(struct device *dev,
> -					 struct device_attribute *attr,
> -					 char *buf)
> +static ssize_t cxlflash_show_port_status(u32 port, struct afu *afu, =
char *buf)
> {
> -	struct Scsi_Host *shost =3D class_to_shost(dev);
> -	struct cxlflash_cfg *cfg =3D (struct cxlflash_cfg =
*)shost->hostdata;
> -	struct afu *afu =3D cfg->afu;
> -
> 	char *disp_status;
> -	int rc;
> -	u32 port;
> 	u64 status;
> -	u64 *fc_regs;
> +	__be64 __iomem *fc_regs;
>=20
> -	rc =3D kstrtouint((attr->attr.name + 4), 10, &port);
> -	if (rc || (port >=3D NUM_FC_PORTS))
> +	if (port >=3D NUM_FC_PORTS)
> 		return 0;
>=20
> 	fc_regs =3D &afu->afu_map->global.fc_regs[port][0];
> -	status =3D
> -	    (readq_be(&fc_regs[FC_MTIP_STATUS / 8]) & =
FC_MTIP_STATUS_MASK);
> +	status =3D readq_be(&fc_regs[FC_MTIP_STATUS / 8]);
> +	status &=3D FC_MTIP_STATUS_MASK;
>=20
> 	if (status =3D=3D FC_MTIP_STATUS_ONLINE)
> 		disp_status =3D "online";
> @@ -2030,31 +2021,69 @@ static ssize_t =
cxlflash_show_port_status(struct device *dev,
> 	else
> 		disp_status =3D "unknown";
>=20
> -	return snprintf(buf, PAGE_SIZE, "%s\n", disp_status);
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", disp_status);
> +}
> +
> +/**
> + * port0_show() - queries and presents the current status of port 0
> + * @dev:	Generic device associated with the host owning the port.
> + * @attr:	Device attribute representing the port.
> + * @buf:	Buffer of length PAGE_SIZE to report back port status in =
ASCII.
> + *
> + * Return: The size of the ASCII string returned in @buf.
> + */
> +static ssize_t port0_show(struct device *dev,
> +			  struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct Scsi_Host *shost =3D class_to_shost(dev);
> +	struct cxlflash_cfg *cfg =3D (struct cxlflash_cfg =
*)shost->hostdata;
> +	struct afu *afu =3D cfg->afu;
> +
> +	return cxlflash_show_port_status(0, afu, buf);
> }
>=20
> /**
> - * cxlflash_show_lun_mode() - presents the current LUN mode of the =
host
> + * port1_show() - queries and presents the current status of port 1
> + * @dev:	Generic device associated with the host owning the port.
> + * @attr:	Device attribute representing the port.
> + * @buf:	Buffer of length PAGE_SIZE to report back port status in =
ASCII.
> + *
> + * Return: The size of the ASCII string returned in @buf.
> + */
> +static ssize_t port1_show(struct device *dev,
> +			  struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct Scsi_Host *shost =3D class_to_shost(dev);
> +	struct cxlflash_cfg *cfg =3D (struct cxlflash_cfg =
*)shost->hostdata;
> +	struct afu *afu =3D cfg->afu;
> +
> +	return cxlflash_show_port_status(1, afu, buf);
> +}
> +
> +/**
> + * lun_mode_show() - presents the current LUN mode of the host
>  * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the lun mode.
> + * @attr:	Device attribute representing the LUN mode.
>  * @buf:	Buffer of length PAGE_SIZE to report back the LUN mode =
in ASCII.
>  *
>  * Return: The size of the ASCII string returned in @buf.
>  */
> -static ssize_t cxlflash_show_lun_mode(struct device *dev,
> -				      struct device_attribute *attr, =
char *buf)
> +static ssize_t lun_mode_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> {
> 	struct Scsi_Host *shost =3D class_to_shost(dev);
> 	struct cxlflash_cfg *cfg =3D (struct cxlflash_cfg =
*)shost->hostdata;
> 	struct afu *afu =3D cfg->afu;
>=20
> -	return snprintf(buf, PAGE_SIZE, "%u\n", afu->internal_lun);
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", afu->internal_lun);
> }
>=20
> /**
> - * cxlflash_store_lun_mode() - sets the LUN mode of the host
> + * lun_mode_store() - sets the LUN mode of the host
>  * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the lun mode.
> + * @attr:	Device attribute representing the LUN mode.
>  * @buf:	Buffer of length PAGE_SIZE containing the LUN mode in =
ASCII.
>  * @count:	Length of data resizing in @buf.
>  *
> @@ -2073,9 +2102,9 @@ static ssize_t cxlflash_show_lun_mode(struct =
device *dev,
>  *
>  * Return: The size of the ASCII string returned in @buf.
>  */
> -static ssize_t cxlflash_store_lun_mode(struct device *dev,
> -				       struct device_attribute *attr,
> -				       const char *buf, size_t count)
> +static ssize_t lun_mode_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> {
> 	struct Scsi_Host *shost =3D class_to_shost(dev);
> 	struct cxlflash_cfg *cfg =3D (struct cxlflash_cfg =
*)shost->hostdata;
> @@ -2094,58 +2123,125 @@ static ssize_t cxlflash_store_lun_mode(struct =
device *dev,
> }
>=20
> /**
> - * cxlflash_show_ioctl_version() - presents the hosts current ioctl =
version
> + * ioctl_version_show() - presents the current ioctl version of the =
host
>  * @dev:	Generic device associated with the host.
>  * @attr:	Device attribute representing the ioctl version.
>  * @buf:	Buffer of length PAGE_SIZE to report back the ioctl =
version.
>  *
>  * Return: The size of the ASCII string returned in @buf.
>  */
> -static ssize_t cxlflash_show_ioctl_version(struct device *dev,
> -					   struct device_attribute =
*attr,
> -					   char *buf)
> +static ssize_t ioctl_version_show(struct device *dev,
> +				  struct device_attribute *attr, char =
*buf)
> {
> 	return scnprintf(buf, PAGE_SIZE, "%u\n", DK_CXLFLASH_VERSION_0);
> }
>=20
> /**
> - * cxlflash_show_dev_mode() - presents the current mode of the device
> + * cxlflash_show_port_lun_table() - queries and presents the port LUN =
table
> + * @port:	Desired port for status reporting.
> + * @afu:	AFU owning the specified port.
> + * @buf:	Buffer of length PAGE_SIZE to report back port status in =
ASCII.
> + *
> + * Return: The size of the ASCII string returned in @buf.
> + */
> +static ssize_t cxlflash_show_port_lun_table(u32 port,
> +					    struct afu *afu,
> +					    char *buf)
> +{
> +	int i;
> +	ssize_t bytes =3D 0;
> +	__be64 __iomem *fc_port;
> +
> +	if (port >=3D NUM_FC_PORTS)
> +		return 0;
> +
> +	fc_port =3D &afu->afu_map->global.fc_port[port][0];
> +
> +	for (i =3D 0; i < CXLFLASH_NUM_VLUNS; i++)
> +		bytes +=3D scnprintf(buf + bytes, PAGE_SIZE - bytes,
> +				   "%03d: %016llX\n", i, =
readq_be(&fc_port[i]));
> +	return bytes;
> +}
> +
> +/**
> + * port0_lun_table_show() - presents the current LUN table of port 0
> + * @dev:	Generic device associated with the host owning the port.
> + * @attr:	Device attribute representing the port.
> + * @buf:	Buffer of length PAGE_SIZE to report back port status in =
ASCII.
> + *
> + * Return: The size of the ASCII string returned in @buf.
> + */
> +static ssize_t port0_lun_table_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct Scsi_Host *shost =3D class_to_shost(dev);
> +	struct cxlflash_cfg *cfg =3D (struct cxlflash_cfg =
*)shost->hostdata;
> +	struct afu *afu =3D cfg->afu;
> +
> +	return cxlflash_show_port_lun_table(0, afu, buf);
> +}
> +
> +/**
> + * port1_lun_table_show() - presents the current LUN table of port 1
> + * @dev:	Generic device associated with the host owning the port.
> + * @attr:	Device attribute representing the port.
> + * @buf:	Buffer of length PAGE_SIZE to report back port status in =
ASCII.
> + *
> + * Return: The size of the ASCII string returned in @buf.
> + */
> +static ssize_t port1_lun_table_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct Scsi_Host *shost =3D class_to_shost(dev);
> +	struct cxlflash_cfg *cfg =3D (struct cxlflash_cfg =
*)shost->hostdata;
> +	struct afu *afu =3D cfg->afu;
> +
> +	return cxlflash_show_port_lun_table(1, afu, buf);
> +}
> +
> +/**
> + * mode_show() - presents the current mode of the device
>  * @dev:	Generic device associated with the device.
>  * @attr:	Device attribute representing the device mode.
>  * @buf:	Buffer of length PAGE_SIZE to report back the dev mode =
in ASCII.
>  *
>  * Return: The size of the ASCII string returned in @buf.
>  */
> -static ssize_t cxlflash_show_dev_mode(struct device *dev,
> -				      struct device_attribute *attr, =
char *buf)
> +static ssize_t mode_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> {
> 	struct scsi_device *sdev =3D to_scsi_device(dev);
>=20
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> -			sdev->hostdata ? "superpipe" : "legacy");
> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> +			 sdev->hostdata ? "superpipe" : "legacy");
> }
>=20
> /*
>  * Host attributes
>  */
> -static DEVICE_ATTR(port0, S_IRUGO, cxlflash_show_port_status, NULL);
> -static DEVICE_ATTR(port1, S_IRUGO, cxlflash_show_port_status, NULL);
> -static DEVICE_ATTR(lun_mode, S_IRUGO | S_IWUSR, =
cxlflash_show_lun_mode,
> -		   cxlflash_store_lun_mode);
> -static DEVICE_ATTR(ioctl_version, S_IRUGO, =
cxlflash_show_ioctl_version, NULL);
> +static DEVICE_ATTR_RO(port0);
> +static DEVICE_ATTR_RO(port1);
> +static DEVICE_ATTR_RW(lun_mode);
> +static DEVICE_ATTR_RO(ioctl_version);
> +static DEVICE_ATTR_RO(port0_lun_table);
> +static DEVICE_ATTR_RO(port1_lun_table);
>=20
> static struct device_attribute *cxlflash_host_attrs[] =3D {
> 	&dev_attr_port0,
> 	&dev_attr_port1,
> 	&dev_attr_lun_mode,
> 	&dev_attr_ioctl_version,
> +	&dev_attr_port0_lun_table,
> +	&dev_attr_port1_lun_table,
> 	NULL
> };
>=20
> /*
>  * Device attributes
>  */
> -static DEVICE_ATTR(mode, S_IRUGO, cxlflash_show_dev_mode, NULL);
> +static DEVICE_ATTR_RO(mode);
>=20
> static struct device_attribute *cxlflash_dev_attrs[] =3D {
> 	&dev_attr_mode,
> --=20
> 2.1.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
